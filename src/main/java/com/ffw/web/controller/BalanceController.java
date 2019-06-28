package com.ffw.web.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("balance")
public class BalanceController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(BalanceController.class);

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

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		if (user.getString("ROLE_ID").equals(IConstant.STRING_1)) {
			// 青菜进入admin
			pd.put("DM_TYPE", "domain");
			// 查询所有区域下的内容
		}
		if (user.getString("ROLE_ID").equals(IConstant.STRING_2)) {
			// 区域进入
			pd.put("DM_ID", user.getString("DM_ID"));
			pd.put("DM_TYPE", "market");
			// 查询所有商城下的内容
		}
		if (user.getString("ROLE_ID").equals(IConstant.STRING_3)) {
			// 商城进入
			pd.put("DM_ID", user.getString("DM_ID"));
			pd.put("DM_TYPE", "shop");
		}

		PageData count = rest.post(IConstant.FFW_SERVICE_KEY, "deduct/findCount", pd, PageData.class);
		mv.addObject("count", count);

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "deduct/listPage", pd, Page.class);

		//Page page2 = rest.post(IConstant.FFW_SERVICE_KEY, "deduct/listPage", pd2, Page.class);

		mv.setViewName("/balance/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		//mv.addObject("page2", page2);
		logger.info("分页查询机构结算信息");
		return mv;
	}

	@RequestMapping("listPage2")
	@ResponseBody
	public JSONObject listPage2() throws Exception {
		JSONObject jsObject=new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		String dm_id2 = pd.getString("dm_id2");
		if (null != dm_id2 && !"".equals(dm_id2)) {
			String DM_TYPE2 = pd.getString("DM_TYPE2");
			if (DM_TYPE2.equals("domain")){
				pd.put("DM_ID", dm_id2);
				pd.put("DM_TYPE", "market");
				jsObject.put("ac","商城结算明细");
			}else if (DM_TYPE2.equals("market")){
				pd.put("DM_ID", dm_id2);
				pd.put("DM_TYPE", "shop");
				jsObject.put("ac","商户结算明细");
			}
			Page page = rest.post(IConstant.FFW_SERVICE_KEY, "deduct/listPage", pd, Page.class);

			jsObject.put("success","true");
			jsObject.put("data",page.getData());

			jsObject.put("message","成功");
			System.out.println(jsObject);
			return jsObject;
		}
		return null;

	}

}
