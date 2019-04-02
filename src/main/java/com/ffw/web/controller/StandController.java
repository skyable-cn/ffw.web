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
@RequestMapping("stand")
public class StandController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(StandController.class);

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

		pd.put("CREATETIME", DateUtil.getTime());

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "stand/save", pd,
				PageData.class);

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(
				getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest
						.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID()
						+ fileOriginaName.substring(fileOriginaName
								.lastIndexOf("."));
				File fileNew = new File(fileConfig.getDirImage()
						+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("STAND_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_3);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "展位" }, ""));
		mv.setViewName("redirect:/stand/listPage");
		logger.info("新增展位成功");
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
	public ModelAndView delete(@RequestParam String STAND_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("STAND_ID", STAND_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "stand/delete", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "展位" },
						""));
		mv.setViewName("redirect:/stand/listPage");
		logger.info("删除展位成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "stand/edit", pd, PageData.class);

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(
				getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest
						.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID()
						+ fileOriginaName.substring(fileOriginaName
								.lastIndexOf("."));
				File fileNew = new File(fileConfig.getDirImage()
						+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("STAND_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_3);

				PageData pdft = rest.post(IConstant.FFW_SERVICE_KEY,
						"file/findBy", pdf, PageData.class);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdft,
						PageData.class);

				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "展位" },
						""));
		mv.setViewName("redirect:/stand/listPage");
		logger.info("修改展位成功");
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

		PageData pdm = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"stand/listAllType", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "stand/listPage", pd,
				Page.class);

		mv.setViewName("/stand/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询展位信息");
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

		PageData pdm = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"stand/listAllType", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		PageData pdm2 = new PageData();
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		mv.addObject("pd", pd);
		mv.setViewName("stand/add");
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

		PageData pdm = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"stand/listAllType", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		PageData pdm2 = new PageData();
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "stand/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("stand/edit");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"stand/listAllType", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		PageData pdm2 = new PageData();
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "stand/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("stand/info");
		return mv;
	}
}
