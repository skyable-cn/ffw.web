package com.ffw.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("desktop")
public class DesktopController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping("/admin")
	public ModelAndView admin() {
		ModelAndView mv = this.getModelAndView();

		PageData pd1 = new PageData();
		pd1.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		List<PageData> domainData = rest.postForList(IConstant.FFW_SERVICE_KEY, "domain/listAll", pd1,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("domainDataSize", domainData.size());

		PageData pd2 = new PageData();
		pd2.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		List<PageData> marketData = rest.postForList(IConstant.FFW_SERVICE_KEY, "market/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("marketDataSize", marketData.size());

		PageData pd3 = new PageData();
		pd3.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pd3,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopDataSize", shopData.size());

		PageData pd4 = new PageData();
		pd4.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY, "goods/listAll", pd4,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsDataSize", goodsData.size());

		mv.setViewName("/desktop/admin");
		return mv;
	}

	@RequestMapping("/domain")
	public ModelAndView domain() {
		ModelAndView mv = this.getModelAndView();

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);

		PageData pd2 = new PageData();
		pd2.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		pd2.put("DOMAIN_ID", user.getString("DM_ID"));
		List<PageData> marketData = rest.postForList(IConstant.FFW_SERVICE_KEY, "market/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("marketDataSize", marketData.size());

		PageData pd3 = new PageData();
		pd3.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		pd3.put("DOMAIN_ID", user.getString("DM_ID"));
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pd3,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopDataSize", shopData.size());

		PageData pd4 = new PageData();
		pd4.put("CCDT", new SimpleDateFormat("yyyy-MM").format(new Date()));
		pd4.put("DOMAIN_ID", user.getString("DM_ID"));
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY, "goods/listAll", pd4,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsDataSize", goodsData.size());

		mv.setViewName("/desktop/domain");
		return mv;
	}

	@RequestMapping("/market")
	public ModelAndView market() {
		ModelAndView mv = this.getModelAndView();

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);

		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MARKET_ID", user.getString("DM_ID"));
		pd.put("CDT", DateUtil.getTime());
		pd.put("CDTD", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		pd.put("CDTM", new SimpleDateFormat("yyyy-MM").format(new Date()));
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "market/findDesk", pd, PageData.class);
		mv.addObject("pd", pd); // 放入视图容器
		mv.setViewName("/desktop/market");
		return mv;
	}
}
