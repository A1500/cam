package com.inspur.cams.comm.menuconfig.domain;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.permit.menu.dao.IMenuItemDao;
import org.loushang.bsp.permit.menu.dao.IMenuStruDao;
import org.loushang.bsp.permit.menu.data.MenuStru;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.menuconfig.dao.IPubMenuConfigDao;

public class CustomMenuDomain implements ICustomMenuDomain {
	@Reference
	private IMenuItemDao imenuItemDao = null;
	@Reference
	private IMenuStruDao imenuStruDao = null;
	@Reference
	private IPubMenuConfigDao pubMenuConfigDao = null;

	public void updatePk(Map<String, String> map) {
		//前期数据准备
		String code = (String)map.get("CODE"); //修改后
		code = code.trim().toUpperCase();
		String oldCode = (String)map.get("OLD_CODE"); //修改前
		oldCode = oldCode.trim().toUpperCase();
		String config = (String)map.get("CONFIG"); //个性化菜单ID
		if(StringUtils.isEmpty(code) || StringUtils.isEmpty(oldCode)) {
			throw new RuntimeException("模块英文简称错误！");
		}
		String oldPrexx = "";
		int len = code.length();
		int j = 0;
		while(j<len) {
			oldPrexx+="0";
			j++;
		}
		
		//更新PUB_MENU_STRU-系统预置菜单
		updateMenuStru("1", code, oldCode, oldPrexx, len);
		
		//个性化菜单
		//	条件：不为空且不为系统预置菜单(代码为1)
		if(StringUtils.isNotEmpty(config) && !"1".equals(config)) {
			updateMenuStru(config, code, oldCode, oldPrexx, len);
		}
		
		//过滤PUB_MENU_ITEM
		//更新PUB_MENU_ITEM中MENU_ID为子系统编码+原最大号
		//	条件：仅更新MODULE_CODE以指定子系统编码起头且MENU_ID以000起头
		StringBuffer itemSql = new StringBuffer();
		itemSql.append("UPDATE PUB_MENU_ITEM T SET T.MENU_ID = '").append(code).append("' || SUBSTR(T.MENU_ID,").append((len+1)).append(") WHERE ");
		itemSql.append(" MODULE_CODE LIKE ?||'%' AND MENU_ID LIKE ?||'%'");
		int[] itemTypes = new int[2];
		itemTypes[0] = Types.VARCHAR;
		itemTypes[1] = Types.VARCHAR;
		Object[] itemArgs = new Object[2];
		itemArgs[0] = oldCode;
		itemArgs[1] = oldPrexx;
		pubMenuConfigDao.exeUpdate(itemSql.toString(), itemTypes, itemArgs);
		
//		throw new RuntimeException("错误!");
	}
	
	/**
	 * 更新PUB_MENU_STRU表
	 */
	private void updateMenuStru(String menuTypeId, String code, String oldCode, String oldPrexx, int len) {
		//过滤PUB_MENU_STRU
		//1.更新PUB_MENU_STRU表的主键
		//	条件：000起头且MENU_ID/PARENT_MENU_ID为指定模块的
		StringBuffer struSql = new StringBuffer();
		struSql.append("UPDATE PUB_MENU_STRU T SET T.MENU_STRU_ID = '").append(code).append("' || SUBSTR(T.MENU_STRU_ID,").append((len+1));
		struSql.append(") WHERE T.MENU_TYPE_ID=? AND T.MENU_STRU_ID LIKE ?||'%'");
		struSql.append(" AND (T.MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%')");
		struSql.append("  OR T.PARENT_MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%'))");

		int[] struTypes = new int[4];
		struTypes[0] = Types.VARCHAR;
		struTypes[1] = Types.VARCHAR;
		struTypes[2] = Types.VARCHAR;
		struTypes[3] = Types.VARCHAR;
		Object[] struArgs = new Object[4];
		struArgs[0] = menuTypeId;
		struArgs[1] = oldPrexx;
		struArgs[2] = oldCode;
		struArgs[3] = oldCode;
		pubMenuConfigDao.exeUpdate(struSql.toString(), struTypes, struArgs);
		

		//2.更新PUB_MENU_STRU表的MENU_ID
		//	条件：000起头且MENU_ID/PARENT_MENU_ID为指定模块的
		StringBuffer struSql2 = new StringBuffer();
		struSql2.append("UPDATE PUB_MENU_STRU T SET T.MENU_ID = '").append(code).append("' || SUBSTR(T.MENU_ID,").append((len+1));
		struSql2.append(") WHERE T.MENU_TYPE_ID=? AND T.MENU_ID LIKE ?||'%'");
		struSql2.append(" AND (T.MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%')");
		struSql2.append("  OR T.PARENT_MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%'))");

		int[] struTypes2 = new int[4];
		struTypes2[0] = Types.VARCHAR;
		struTypes2[1] = Types.VARCHAR;
		struTypes2[2] = Types.VARCHAR;
		struTypes2[3] = Types.VARCHAR;
		Object[] struArgs2 = new Object[4];
		struArgs2[0] = menuTypeId;
		struArgs2[1] = oldPrexx;
		struArgs2[2] = oldCode;
		struArgs2[3] = oldCode;
		pubMenuConfigDao.exeUpdate(struSql2.toString(), struTypes2, struArgs2);
		
		
		//3.更新PUB_MENU_STRU表的PARENT_MENU_ID
		//	条件：000起头且MENU_ID/PARENT_MENU_ID为指定模块的
		StringBuffer struSql3 = new StringBuffer();
		struSql3.append("UPDATE PUB_MENU_STRU T SET T.PARENT_MENU_ID = '").append(code).append("' || SUBSTR(T.PARENT_MENU_ID,").append((len+1));
		struSql3.append(") WHERE T.MENU_TYPE_ID=? AND T.PARENT_MENU_ID LIKE ?||'%'");
		struSql3.append(" AND (T.MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%')");
		struSql3.append("  OR T.PARENT_MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%'))");

		int[] struTypes3 = new int[4];
		struTypes3[0] = Types.VARCHAR;
		struTypes3[1] = Types.VARCHAR;
		struTypes3[2] = Types.VARCHAR;
		struTypes3[3] = Types.VARCHAR;
		Object[] struArgs3 = new Object[4];
		struArgs3[0] = menuTypeId;
		struArgs3[1] = oldPrexx;
		struArgs3[2] = oldCode;
		struArgs3[3] = oldCode;
		pubMenuConfigDao.exeUpdate(struSql3.toString(), struTypes3, struArgs3);
		
		
		//4.更新PUB_MENU_STRU表的MENU_PATH-头
		//	条件：000起头且MENU_ID/PARENT_MENU_ID为指定模块的
		StringBuffer struSql4 = new StringBuffer();
		struSql4.append("UPDATE PUB_MENU_STRU T SET T.MENU_PATH = '").append(code).append("' || SUBSTR(T.MENU_PATH,").append((len+1));
		struSql4.append(") WHERE T.MENU_TYPE_ID=? AND T.MENU_PATH LIKE ?||'%'");
		struSql4.append(" AND (T.MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%')");
		struSql4.append("  OR T.PARENT_MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%'))");

		int[] struTypes4 = new int[4];
		struTypes4[0] = Types.VARCHAR;
		struTypes4[1] = Types.VARCHAR;
		struTypes4[2] = Types.VARCHAR;
		struTypes4[3] = Types.VARCHAR;
		Object[] struArgs4 = new Object[4];
		struArgs4[0] = menuTypeId;
		struArgs4[1] = oldPrexx;
		struArgs4[2] = oldCode;
		struArgs4[3] = oldCode;
		pubMenuConfigDao.exeUpdate(struSql4.toString(), struTypes4, struArgs4);

		
		//5.更新PUB_MENU_STRU表的MENU_PATH-中间
		//	条件：MENU_ID/PARENT_MENU_ID为指定模块的
		StringBuffer struSql5 = new StringBuffer();
		struSql5.append("UPDATE PUB_MENU_STRU T SET T.MENU_PATH = REPLACE(T.MENU_PATH, '#").append(oldPrexx).append("', '#").append(code).append("')");
		struSql5.append(" WHERE T.MENU_TYPE_ID=? ");
		struSql5.append(" AND (T.MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%')");
		struSql5.append("  OR T.PARENT_MENU_ID IN (SELECT MENU_ID FROM PUB_MENU_ITEM M WHERE M.MODULE_CODE LIKE ?||'%'))");

		int[] struTypes5 = new int[3];
		struTypes5[0] = Types.VARCHAR;
		struTypes5[1] = Types.VARCHAR;
		struTypes5[2] = Types.VARCHAR;
		Object[] struArgs5 = new Object[3];
		struArgs5[0] = menuTypeId;
		struArgs5[1] = oldCode;
		struArgs5[2] = oldCode;
		pubMenuConfigDao.exeUpdate(struSql5.toString(), struTypes5, struArgs5);
	}
}
