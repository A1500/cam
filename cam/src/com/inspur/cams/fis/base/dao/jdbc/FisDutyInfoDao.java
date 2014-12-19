package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.fis.base.dao.IFisDutyInfoDao;
import com.inspur.cams.fis.base.data.FisDutyInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisDutyInfoDao
 * @Description: TODO 殡葬业务人员岗位信息表Dao的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisDutyInfoDao extends EntityDao<FisDutyInfo> implements IFisDutyInfoDao {

	public FisDutyInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisDutyInfo.class;
	}

	/*
	 * public void delete(String key) { int[] type = new int[1]; Object[] value = new Object[1]; type[0] = Types.VARCHAR; value[0] = key;
	 * this.executeUpdate("DELETE FIS_DUTY_INFO WHERE PEOPLE_ID = ?", type, value); }
	 */

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据上报导出数据方法)
	 * @param set
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set) {
		String qStartTime = (String) set.get("qStartTime");
		String qEndTime = (String) set.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_DUTY_INFO O ");
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
