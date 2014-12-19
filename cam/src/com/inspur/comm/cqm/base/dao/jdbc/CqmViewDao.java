package com.inspur.comm.cqm.base.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.comm.cqm.base.dao.ICqmViewDao;
import com.inspur.comm.cqm.base.data.CqmView;

/**
 * 自定义统计报表视图表dao
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewDao extends EntityDao<CqmView> implements ICqmViewDao {
	
	private static String QUERY_BY_VIEW_REL = "SELECT * FROM CQM_VIEW WHERE VIEW_ID IN(SELECT VIEW_ID FROM CQM_VIEW_REL WHERE MODULE_ID = ?)";
	
	@Override
	public Class<CqmView> getEntityClass() {
		return CqmView.class;
	}
	
	/**
	 * 查询 根据模型视图关系查询视图字典
	 * @param pset
	 * @return
	 */
	 @SuppressWarnings("unchecked")
	public DataSet queryByViewRel(String moduleId) {
		List<Map<String, String>> list = executeQuery(QUERY_BY_VIEW_REL, new int[]{ Types.VARCHAR }, new Object[]{ moduleId });
		
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map<String,String> map = list.get(i);
			CqmView cqmView = new CqmView();
			cqmView.setViewId(map.get("VIEW_ID"));
			cqmView.setViewName(map.get("VIEW_NAME"));
			cqmView.setViewLogic(map.get("VIEW_LOGIC"));
			ds.addRecord(cqmView);
		}
		return ds;
	}

}