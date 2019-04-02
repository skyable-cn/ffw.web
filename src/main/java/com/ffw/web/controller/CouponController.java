package com.ffw.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("coupon")
public class CouponController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(CouponController.class);

	@Autowired
	RestTemplateUtil rest;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		rest.post(IConstant.FFW_SERVICE_KEY, "coupon/save", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "现金券设置" },
						""));
		mv.setViewName("redirect:/coupon/listPage");
		logger.info("新增现金券设置成功");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ModelAndView delete(@RequestParam String COUPON_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("COUPON_ID", COUPON_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "coupon/delete", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS",
						new Object[] { "现金券设置" }, ""));
		mv.setViewName("redirect:/coupon/listPage");
		logger.info("删除现金券设置成功");

		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		rest.post(IConstant.FFW_SERVICE_KEY, "coupon/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS",
						new Object[] { "现金券设置" }, ""));
		mv.setViewName("redirect:/coupon/listPage");
		logger.info("修改现金券设置成功");
		return mv;
	}

	@RequestMapping("listPage")
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "coupon/listPage", pd,
				Page.class);

		mv.setViewName("/coupon/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询现金券设置信息");
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		mv.addObject("pd", pd);
		mv.setViewName("coupon/add");
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "coupon/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("coupon/edit");
		return mv;
	}
}
