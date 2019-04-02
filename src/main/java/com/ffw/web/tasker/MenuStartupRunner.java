package com.ffw.web.tasker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;

import com.ffw.api.model.Menu;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Component
public class MenuStartupRunner implements CommandLineRunner {

	private Logger logger = LoggerFactory.getLogger(MenuStartupRunner.class);

	public static Map<Integer, List<Menu>> systemMenus = new HashMap<Integer, List<Menu>>();

	@Autowired
	RestTemplateUtil rest;

	@Override
	public void run(String... arg0) throws Exception {
		try {
			Integer[] roles = new Integer[] { 1, 2, 3 };
			for (Integer role : roles) {
				PageData pd = new PageData();
				pd.put("ROLE_ID", role);
				List<Menu> menus = rest.postForList(IConstant.FFW_SERVICE_KEY,
						"menu/listRoleMenu", pd,
						new ParameterizedTypeReference<List<Menu>>() {
						});
				List<Menu> menuTemp = new ArrayList<Menu>();
				Map<Integer, List<Menu>> subMenu = new HashMap<Integer, List<Menu>>();

				for (Menu menu : menus) {
					if (menu.getPid() == 0) {
						menuTemp.add(menu);
					} else {
						List<Menu> menust = null;
						if (subMenu.containsKey(menu.getPid())) {
							menust = subMenu.get(menu.getPid());
							menust.add(menu);
							subMenu.put(menu.getPid(), menust);
						} else {
							menust = new ArrayList<Menu>();
							menust.add(menu);
							subMenu.put(menu.getPid(), menust);
						}
					}
				}

				List<Menu> menuLast = new ArrayList<Menu>();
				for (Menu menu : menuTemp) {
					if (!menu.getUrl().equals("#")) {
						menuLast.add(menu);
					} else {
						if (CollectionUtils
								.isNotEmpty(subMenu.get(menu.getId()))) {
							menu.setSubMenu(subMenu.get(menu.getId()));
							menuLast.add(menu);
						}
					}
				}
				systemMenus.put(role, menuLast);
			}
			logger.info("系统初始化菜单成功");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("初始化菜单发生异常");
		}
	}
}
