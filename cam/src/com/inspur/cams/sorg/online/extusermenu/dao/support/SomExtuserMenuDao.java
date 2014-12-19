package com.inspur.cams.sorg.online.extusermenu.dao.support;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.extusermenu.dao.ISomExtuserMenuDao;
import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * @title:SomExtuserMenuDao
 * @description:
 * @author:
 * @since:2012-10-31
 * @version:1.0
*/
 public class SomExtuserMenuDao extends EntityDao<SomExtuserMenu> implements ISomExtuserMenuDao{
	// 根据用户内码逻辑删除用户信息
	public static String DELETE_BY_USER_ID_REAL = "DELETE FROM SOM_EXTUSER_MENU  WHERE USER_ID=?";

 	public SomExtuserMenuDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomExtuserMenu.class;
	}
    public void deleteStruAll() {
		executeUpdate("delete from SomExtuserMenu");
	}

   /**
	 * 逻辑删除外部单位用户信息
	 * @param userId
	 */
	public  void deleteSomExtUserMenu(String userId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {userId};
		executeUpdate(DELETE_BY_USER_ID_REAL, types, objs);
	}
	/**
	 *  增加菜单
	 * 2014年3月20日
	 *
	 */
	public void insertmenu(SomExtuserMenu somExtuserMenu) {
		// TODO Auto-generated method stub
	insert(somExtuserMenu);
	}
}
