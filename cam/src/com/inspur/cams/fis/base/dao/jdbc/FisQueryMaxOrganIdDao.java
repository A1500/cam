package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisQueryMaxOrganIdDao;
import com.inspur.cams.fis.base.data.FisCemeteryOrgan;

/**
 * @Path com.inspur.cams.fis.base.dao
 * @Description: TODO 查询数据库中organId后两位最大值
 * @author lx
 * @date 2013-07-25
 */
public class FisQueryMaxOrganIdDao extends EntityDao<FisCemeteryOrgan>
		implements IFisQueryMaxOrganIdDao {
	public FisQueryMaxOrganIdDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	protected Class getEntityClass() {
		return FisCemeteryOrgan.class;
	}

	public String queryMaxOrganId(String organId) {
		String id = organId + "%";
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		sql
				.append(" select * from FIS_CEMETERY_ORGAN where organ_id=( select max(organ_id) organ_id from FIS_CEMETERY_ORGAN where organ_id like ? ) ");
		if (StringUtils.isNotEmpty(id)) {
			typeList.add(Types.VARCHAR);
			objsList.add(id);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return (String) ds.getRecord(0).get("ORGAN_ID");
	}
}
