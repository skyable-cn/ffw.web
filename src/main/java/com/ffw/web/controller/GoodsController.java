package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.config.FileConfig;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("goods")
public class GoodsController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(GoodsController.class);

	@Autowired
	RestTemplateUtil rest;

	@Autowired
	FileConfig fileConfig;

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

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);

		pd.put("CREATETIME", DateUtil.getTime());
		String userName = user.getString("NICKNAME");
		if (StringUtils.isEmpty(userName)) {
			userName = user.getString("USERNAME");
		}
		pd.put("CREATEPEOPLE", userName);
		pd.put("SELLED", IConstant.STRING_0);
		pd.put("BUYNUMBER", IConstant.STRING_0);
		pd.put("VIEWNUMBER1", IConstant.STRING_0);
		pd.put("VIEWNUMBER2", IConstant.STRING_0);
		pd.put("PRAISENUMBER", IConstant.STRING_0);
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "goods/save", pd, PageData.class);

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID() + fileOriginaName.substring(fileOriginaName.lastIndexOf("."));

				File fileNew = new File(fileConfig.getDirImage() + File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("GOODS_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);

				String FILETYPE = IConstant.STRING_1;
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_2;
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf, PageData.class);
			}
		}

		mv.addObject("msg", getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "商品" }, ""));
		mv.setViewName("redirect:/goods/manage");
		logger.info("新增商品成功");
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
	public ModelAndView delete(@RequestParam String GOODS_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("GOODS_ID", GOODS_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "goods/delete", pd, PageData.class);

		mv.addObject("msg", getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "商品" }, ""));
		mv.setViewName("redirect:/goods/manage");
		logger.info("删除商品成功");

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

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);

		pd.put("UPDATETIME", DateUtil.getTime());
		String userName = user.getString("NICKNAME");
		if (StringUtils.isEmpty(userName)) {
			userName = user.getString("USERNAME");
		}
		pd.put("UPDATEPEOPLE", userName);

		rest.post(IConstant.FFW_SERVICE_KEY, "goods/edit", pd, PageData.class);

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID() + fileOriginaName.substring(fileOriginaName.lastIndexOf("."));
				File fileNew = new File(fileConfig.getDirImage() + File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("GOODS_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);

				String FILETYPE = IConstant.STRING_1;
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_2;

					PageData pdfd = new PageData();
					pdfd.put("FILE_ID", pd.getString("HBFILE_ID"));
					rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdfd, PageData.class);
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf, PageData.class);
			}
		}

		mv.addObject("msg", getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "商品" }, ""));
		mv.setViewName("redirect:/goods/manage");
		logger.info("修改商品成功");
		return mv;
	}

	@RequestMapping("manage")
	public ModelAndView listPageManage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		if (user.getString("ROLE_ID").equals(IConstant.STRING_2)) {
			pdm2.put("DOMAIN_ID", user.getString("DM_ID"));
		}
		if (user.getString("ROLE_ID").equals(IConstant.STRING_3)) {
			pdm2.put("MARKET_ID", user.getString("DM_ID"));
		}
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		if (user.getString("ROLE_ID").equals(IConstant.STRING_2)) {
			pd.put("DOMAIN_ID", user.getString("DM_ID"));
		}
		if (user.getString("ROLE_ID").equals(IConstant.STRING_3)) {
			pd.put("MARKET_ID", user.getString("DM_ID"));
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "goods/listPage", pd, Page.class);

		mv.setViewName("/goods/listManage");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商品信息");
		return mv;
	}

	@RequestMapping("search")
	public ModelAndView listPageSearch() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		pd.put("SHOP_ID", user.getString("DM_ID"));

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "goods/listPage", pd, Page.class);

		mv.setViewName("/goods/listSearch");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商品信息");
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

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		pdm2.put("MARKET_ID", user.getString("DM_ID"));
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		mv.addObject("pd", pd);
		mv.setViewName("goods/add");
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

		PageData user = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		pdm2.put("MARKET_ID", user.getString("DM_ID"));
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		PageData pdm3 = new PageData();
		pdm3.put("REFERENCE_ID", pd.getString("GOODS_ID"));
		pdm3.put("FILETYPE", IConstant.STRING_1);
		List<PageData> fileDataList = rest.postForList(IConstant.FFW_SERVICE_KEY, "file/listAll", pdm3,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("fileDataList", fileDataList);

		PageData pdm4 = new PageData();
		pdm4.put("REFERENCE_ID", pd.getString("GOODS_ID"));
		pdm4.put("FILETYPE", IConstant.STRING_2);
		PageData fileData = rest.post(IConstant.FFW_SERVICE_KEY, "file/findBy", pdm4, PageData.class);
		mv.addObject("fileData", fileData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pd, PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("goods/edit");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY, "shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		PageData pdm3 = new PageData();
		pdm3.put("REFERENCE_ID", pd.getString("GOODS_ID"));
		pdm3.put("FILETYPE", IConstant.STRING_1);
		List<PageData> fileDataList = rest.postForList(IConstant.FFW_SERVICE_KEY, "file/listAll", pdm3,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("fileDataList", fileDataList);

		PageData pdm4 = new PageData();
		pdm4.put("REFERENCE_ID", pd.getString("GOODS_ID"));
		pdm4.put("FILETYPE", IConstant.STRING_2);
		PageData fileData = rest.post(IConstant.FFW_SERVICE_KEY, "file/findBy", pdm4, PageData.class);
		mv.addObject("fileData", fileData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pd, PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("goods/info");
		return mv;
	}

	@RequestMapping("/image/delete")
	@ResponseBody
	public PageData imagedelete(@RequestParam String FILE_ID) throws Exception {
		PageData pd = new PageData();
		pd.put("FILE_ID", FILE_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pd, PageData.class);

		logger.info("删除文件成功");

		return pd;
	}
}
