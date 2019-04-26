package com.ffw.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("withdraw")
public class WithdrawController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(WithdrawController.class);

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

			rest.post(IConstant.FFW_APP_KEY, "wxTransfers", pdw, PageData.class);
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_APPROVE_SUCCESS",
						new Object[] { "审核分销提现" }, ""));
		mv.setViewName("redirect:/shop/listPage");
		logger.info("审核分销提现成功");
		return mv;
	}
}
