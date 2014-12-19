package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisCemeteryOrganDao;
import com.inspur.cams.fis.base.data.FisCemeteryOrgan;
/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisCemeteryOrganDao
 * @Description: TODO 殡葬业务公墓信息表dao的实现
 * @author muqi
 * @date 2012-04-09
 */
public class FisCemeteryOrganDao extends EntityDao<FisCemeteryOrgan> implements IFisCemeteryOrganDao {

	public FisCemeteryOrganDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeteryOrgan.class;
	}

	public DataSet queryForExport(ParameterSet pset) {
		String qStartTime = (String) pset.get("qStartTime");
		String qEndTime = (String) pset.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_CEMETERY_ORGAN O ");
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
