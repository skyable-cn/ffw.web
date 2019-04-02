package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("groups")
public class GroupsController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(GroupsController.class);

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

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "groups/save", pd,
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
				pdf.put("REFERENCE_ID", pd.getString("GROUPS_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);

				String FILETYPE = null;

				if (fileID.equals("file-0")) {
					FILETYPE = IConstant.STRING_5;
				}
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_6;
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "群组" }, ""));
		mv.setViewName("redirect:/groups/listPage");
		logger.info("新增群组成功");
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
	public ModelAndView delete(@RequestParam String GROUPS_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("GROUPS_ID", GROUPS_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "groups/delete", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "群组" },
						""));
		mv.setViewName("redirect:/groups/listPage");
		logger.info("删除群组成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "groups/edit", pd, PageData.class);

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
				pdf.put("REFERENCE_ID", pd.getString("GROUPS_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);

				String FILETYPE = null;

				if (fileID.equals("file-0")) {
					FILETYPE = IConstant.STRING_5;

					PageData pdfd = new PageData();
					pdfd.put("FILE_ID", pd.getString("FILE_ID-0"));
					rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdfd,
							PageData.class);
				}
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_6;

					PageData pdfd = new PageData();
					pdfd.put("FILE_ID", pd.getString("FILE_ID-1"));
					rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdfd,
							PageData.class);
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "群组" },
						""));
		mv.setViewName("redirect:/groups/listPage");
		logger.info("修改群组成功");
		return mv;
	}

	@RequestMapping("listPage")
	public ModelAndView listPageManage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "groups/listPage", pd,
				Page.class);

		mv.setViewName("/groups/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询群组信息");
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
		mv.setViewName("groups/add");
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

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "groups/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("groups/edit");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "groups/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("groups/info");
		return mv;
	}
}
