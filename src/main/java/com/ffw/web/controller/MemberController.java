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
@RequestMapping("member")
public class MemberController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(MemberController.class);

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
		if(user.getString("ROLE_ID").equals(IConstant.STRING_2)){
			pd.put("DOMAIN_ID", user.getString("DM_ID"));
		}else if(user.getString("ROLE_ID").equals(IConstant.STRING_3)){
			pd.put("MARKET_ID", user.getString("DM_ID"));
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "member/listPage", pd,
				Page.class);

		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"member/listAllType", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		mv.setViewName("/member/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询会员用户信息");
		return mv;
	}
}
