package com.ffw.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.api.util.DoubleUtil;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("shopdraw")
public class ShopdrawController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(ShopdrawController.class);

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

		pd.put("SHOPSTATE_ID", IConstant.STRING_2);
		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "shop/listPage", pd,
				Page.class);

		mv.setViewName("/shopdraw/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商户结算信息");
		return mv;
	}

	@RequestMapping("shop/listPage")
	public ModelAndView shopListPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "orders/listPageShop",
				pd, Page.class);

		PageData shop = new PageData();
		shop.put("SHOP_ID", pd.getString("SHOP_ID"));
		shop = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", shop,
				PageData.class);
		mv.addObject("shop", shop);

		mv.setViewName("/shopdraw/listShop");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商户结算信息");
		return mv;
	}

	@RequestMapping("record/listPage")
	public ModelAndView recordListPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "shopdraw/listPage",
				pd, Page.class);

		PageData shop = new PageData();
		shop.put("SHOP_ID", pd.getString("SHOP_ID"));
		shop = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", shop,
				PageData.class);
		mv.addObject("shop", shop);

		mv.setViewName("/shopdraw/listRecord");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商户结算记录信息");
		return mv;
	}

	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData shop = new PageData();
		shop.put("SHOP_ID", pd.getString("SHOP_ID"));
		shop = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", shop,
				PageData.class);
		mv.addObject("shop", shop);

		mv.addObject("pd", pd);
		mv.setViewName("shopdraw/add");
		return mv;
	}

	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String MONEY = pd.getString("MONEY");
		String SHOP_ID = pd.getString("SHOP_ID");

		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);

		String SHOPDRAWSN = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date()) + randomNumber(5);

		pd.put("SHOPDRAWSN", SHOPDRAWSN);
		pd.put("USER_ID", user.getString("USER_ID"));
		pd.put("CDT", DateUtil.getTime());
		pd.put("STATE", IConstant.STRING_0);
		rest.post(IConstant.FFW_SERVICE_KEY, "shopdraw/save", pd,
				PageData.class);

		PageData shop = new PageData();
		shop.put("SHOP_ID", SHOP_ID);
		shop = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", shop,
				PageData.class);
		shop.put("WAITACCOUNT", DoubleUtil.sub(
				Double.parseDouble(shop.getString("WAITACCOUNT")),
				Double.parseDouble(MONEY))

		);
		shop.put("ALREADYACCOUNT", DoubleUtil.sum(
				Double.parseDouble(shop.getString("ALREADYACCOUNT")),
				Double.parseDouble(MONEY)));
		rest.post(IConstant.FFW_SERVICE_KEY, "shop/edit", shop, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS",
						new Object[] { "商户结算记录" }, ""));
		mv.setViewName("redirect:/shopdraw/record/listPage?SHOP_ID="
				+ pd.getString("SHOP_ID"));
		logger.info("新增商户结算记录成功");
		return mv;
	}

	private String randomNumber(int length) {
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		String s = "0123456789";
		for (int i = 0; i < length; i++) {
			sb.append(s.charAt(r.nextInt(s.length())));
		}
		return sb.toString();
	}

}
