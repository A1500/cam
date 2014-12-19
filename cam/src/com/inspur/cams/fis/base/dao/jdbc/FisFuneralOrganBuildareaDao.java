package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisFuneralOrganBuildareaDao;
import com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisFuneralOrganBuildareaDao
 * @Description: TODO 殡葬业务殡仪馆信息表dao的实现
 * @author xuexzh
 * @date 2012-7-12
 */
public class FisFuneralOrganBuildareaDao extends EntityDao<FisFuneralOrganBuildarea> implements IFisFuneralOrganBuildareaDao {

	public FisFuneralOrganBuildareaDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisFuneralOrganBuildarea.class;
	}


	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据导出时查询方法)
	 * @param pSet
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet pSet) {
		String qStartTime = (String) pSet.get("qStartTime");
		String qEndTime = (String) pSet.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_FUNERAL_ORGAN_BUILDAREA O ");
		if (StringUtils.isNotEmpty(qStartTime)) {
			sqlBuffer.append(" where O.CREATE_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qStartTime);
		}
		if (StringUtils.isNotEmpty(qEndTime)) {
			sqlBuffer.append(" and O.CREATE_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qEndTime);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sqlBuffer.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sqlBuffer.toString(), true);
		}
		return ds;
	}
}
