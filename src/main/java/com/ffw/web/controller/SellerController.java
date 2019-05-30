package com.ffw.web.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("seller")
public class SellerController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(SellerController.class);

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
		
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		if(user.getString("ROLE_ID").equals(IConstant.STRING_3)){
			pd.put("MARKET_ID", user.getString("DM_ID"));
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY,
				"member/listPageIncome", pd, Page.class);

		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"member/listAllType", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		mv.setViewName("/seller/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询分销结算信息");
		return mv;
	}

	@RequestMapping("member/listPage")
	public ModelAndView memberListPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "orders/listPageBill",
				pd, Page.class);

		PageData member = new PageData();
		member.put("MEMBER_ID", pd.getString("MEMBER_ID"));
		member = rest.post(IConstant.FFW_SERVICE_KEY, "member/find", member,
				PageData.class);
		mv.addObject("member", member);

		mv.setViewName("/seller/listMember");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询人员分销结算信息");
		return mv;
	}
}
