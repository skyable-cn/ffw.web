package com.ffw.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("manage")
public class ManageController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(ManageController.class);

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
		pd.put("SHOP_ID", user.getString("DM_ID"));
		pd.put("SQLCONDITION", " AND os.STATE IN ( '2' , '3' ) ");

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "orders/listPage", pd,
				Page.class);

		mv.setViewName("/manage/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商户订单信息");
		return mv;
	}
}
