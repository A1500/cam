package com.inspur.cams.sorg.online.extusermenu.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * @title:ISomExtuserMenuDao
 * @description:
 * @author:
 * @since:2012-10-31
 * @version:1.0
*/
 public interface ISomExtuserMenuDao extends BaseCURD<SomExtuserMenu>{
	@Trans
	public void save(List<SomExtuserMenu> list);

	public void deleteSomExtUserMenu(String userId);

	/**
	 * 社会组织外单位增加菜单
	 */
	public void insertmenu(SomExtuserMenu somExtuserMenu);

}

