package com.ffw.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.config.WXPayConfigImpl;
import com.ffw.web.config.WechatMiniConfig;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;
import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConstants.SignType;
import com.github.wxpay.sdk.WXPayUtil;

@Controller
@RequestMapping("withdraw")
public class WithdrawController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(WithdrawController.class);

	@Autowired
	WechatMiniConfig wechatMiniConfig;

	@Autowired
	WXPayConfigImpl config;

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping("listPage")
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/listPage",
				pd, Page.class);

		mv.setViewName("/withdraw/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询用户提现信息");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("withdraw/info");
		return mv;
	}

	@RequestMapping(value = "/goAuditing")
	public ModelAndView goAuditing() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("withdraw/auditing");
		return mv;
	}

	@RequestMapping(value = "/auditing")
	public ModelAndView auditing() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdw = rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/find",
				pd, PageData.class);
		pdw.put("STATE", pd.getString("STATE"));
		pdw.put("REMARK", pd.getString("REMARK"));
		pdw.put("ADT", DateUtil.getTime());
		rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/edit", pdw,
				PageData.class);

		if (pd.getString("STATE").equals(IConstant.STRING_1)) {

			PageData pdm = new PageData();
			pdm.put("MEMBER_ID", pdw.getString("MEMBER_ID"));
			pdm = rest.post(IConstant.FFW_SERVICE_KEY, "member/find", pdm,
					PageData.class);

			logger.info("进入企业付款到个人");
			WXPay wxpay = new WXPay(config, SignType.MD5);
			Map<String, String> parameters = new HashMap<String, String>();
			parameters.put("mch_appid", wechatMiniConfig.getAppid());
			parameters.put("mchid", wechatMiniConfig.getMchid());
			parameters.put("nonce_str", WXPayUtil.generateNonceStr());
			parameters.put("partner_trade_no", pdw.getString("WITHDRAW_ID"));
			parameters.put("openid", pdm.getString("WXOPEN_ID"));
			parameters.put("check_name", "NO_CHECK");
			String fee = String
					.valueOf(Float.parseFloat(pdw.getString("MONEY")) * 100);
			parameters.put("amount", fee.substring(0, fee.indexOf(".")) + "");
			parameters.put("spbill_create_ip", getIpAddr(getRequest()));
			parameters.put("desc", "饭饭网用户提现");
			// 签名
			String sign = WXPayUtil.generateSignature(parameters,
					wechatMiniConfig.getMchkey());
			parameters.put("sign", sign);

			String notityXml = wxpay
					.requestWithCert(
							"https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers",
							parameters, config.getHttpConnectTimeoutMs(),
							config.getHttpReadTimeoutMs());
			System.err.println(notityXml);
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_APPROVE_SUCCESS",
						new Object[] { "审核分销提现" }, ""));
		mv.setViewName("redirect:/withdraw/listPage");
		logger.info("审核分销提现成功");
		return mv;
	}

	private String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			int index = ip.indexOf(",");
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		}
		ip = request.getHeader("X-Real-IP");
		if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			return ip;
		}
		return request.getRemoteAddr();
	}
}
