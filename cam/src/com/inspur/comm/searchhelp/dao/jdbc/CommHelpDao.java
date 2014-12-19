package com.inspur.comm.searchhelp.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.searchhelp.dao.ICommHelpDao;
import com.inspur.comm.searchhelp.data.CommHelp;
import com.inspur.comm.searchhelp.data.HelpDic;


/**
 * 通用帮助dao实现类
 * @author shgtch
 * @date 2011-5-23
 */
public class CommHelpDao extends EntityDao<CommHelp> implements ICommHelpDao {
	
	private static String SPLIT_NOTE = ",";
	
	private static String DIC_VALUE = "VALUE";
	
	private static String DIC_TEXT = "TEXT";
	
	// 通用帮助缓存
	private Map commHelpCache = new HashMap();
	
	@Override
	protected Class getEntityClass() {
		return CommHelp.class;
	}
	
	/**
	 * 获取通用帮助配置，并缓存
	 * @param helpId
	 * @return
	 */
	public CommHelp getCommHelp(String helpId) {
		CommHelp commHelp = (CommHelp) commHelpCache.get(helpId);
		if (commHelp == null) {
			commHelp = get(helpId);
			commHelpCache.put(helpId, commHelp);
		}
		return commHelp;
	}
	
	/**
	 * 保存通用帮助配置，并刷新缓存
	 * @param commHelp
	 */
	public void insertCommHelp(CommHelp commHelp) {
		insert(commHelp);
		commHelpCache.put(commHelp.getHelpId(), commHelp);
	}
	
	/**
	 * 更新通用帮助配置，并刷新缓存
	 * @param commHelp
	 */
	public void updateCommHelp(CommHelp commHelp) {
		update(commHelp);
		commHelpCache.put(commHelp.getHelpId(), commHelp);
	}
	
	/**
	 * 删除通用帮助配置，并刷新缓存
	 * @param helpId
	 */
	public void deleteCommHelp(String helpId) {
		delete(helpId);
		commHelpCache.remove(helpId);
	}
	
	/**
	 * 查询通用帮助字典项
	 * @param ps
	 * @param commHelp
	 * @return
	 */
	public DataSet getHelpDataset(ParameterSet ps, CommHelp commHelp) {
		String[] showFieldArr = commHelp.getShowField().split(SPLIT_NOTE);
		String[] searchOprArr = commHelp.getSearchOpr().split(SPLIT_NOTE);
		
		// 组装查询字典Sql
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM ");
		sql.append(commHelp.getHelpTable());
		sql.append(" WHERE 1=1");
		// 配置where语句
		if (commHelp.getHelpWhere() != null && !"".equals(commHelp.getHelpWhere())) {
			sql.append(" AND ");
			sql.append(commHelp.getHelpWhere());
		}
		// 拼装where查询语句
		List<Object> valList = new ArrayList<Object>();
		int paramNum = 0;
		for (int i = 0; i < showFieldArr.length; i++) {
			String param = (String) ps.getParameter(showFieldArr[i]);
			if (param != null && !"".equals(param)) {
				sql.append(" AND ");
				sql.append(showFieldArr[i]);
				sql.append(" ");
				sql.append(searchOprArr[i]);
				sql.append(" ?");
				paramNum++;
				if ("LIKE".equals(searchOprArr[i])) {
					valList.add(param + "%");
				} else {
					valList.add(param);
				}
			}
		}
		int[] types = new int[paramNum];
		for (int i = 0; i < paramNum; i++) {
			types[i] = Types.VARCHAR;
		}
		// 组装排序
		if (commHelp.getSortOrder() != null && !"".equals(commHelp.getSortOrder())) {
			sql.append(" ORDER BY ");
			sql.append(commHelp.getSortOrder());
		}
		
		return executeDataset(sql.toString(), types, valList.toArray(), ps.getPageStart(), ps.getPageLimit(), true);
	}
	
	/**
	 * 查询字典表集合
	 * @param commHelp
	 * @return
	 */
	public DataSet getSelectDataset(CommHelp commHelp) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ");
		sql.append(commHelp.getIdField());
		sql.append(" VALUE,");
		sql.append(commHelp.getNameField());
		sql.append(" TEXT FROM ");
		sql.append(commHelp.getHelpTable());
		if (commHelp.getHelpWhere() != null && !"".equals(commHelp.getHelpWhere())) {
			sql.append(" WHERE ");
			sql.append(commHelp.getHelpWhere());
		}
		if (commHelp.getSortOrder() != null && !"".equals(commHelp.getSortOrder())) {
			sql.append(" ORDER BY ");
			sql.append(commHelp.getSortOrder());
		}
		List<Map> list = executeQuery(sql.toString());
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			HelpDic helpDic = new HelpDic();
			helpDic.setValue((String) map.get(DIC_VALUE));
			helpDic.setText((String) map.get(DIC_TEXT));
			ds.addRecord(helpDic);
		}
		return ds;
	}

	/**
	 * 查询字典中key对应的value
	 * @param key
	 * @param commHelp
	 * @return
	 */
	public DataSet getDicValue(CommHelp commHelp, String key) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM ");
		sql.append(commHelp.getHelpTable());
		sql.append(" WHERE ");
		sql.append(commHelp.getIdField());
		if (key.indexOf(",") < 0) {
			sql.append("=?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { key };
			return executeDataset(sql.toString(), types, args, true);
		} else {
			sql.append(" IN('");
			sql.append(key.replaceAll(",", "','"));
			sql.append("')");
			return this.executeDataset(sql.toString(), true);
		}
	}
	
}
