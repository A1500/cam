package com.inspur.cams.dis.base.dao.jdbc;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.dis.base.dao.IDisCurrentMoneyDao;
import com.inspur.cams.dis.base.data.DisCurrentMoney;

/**
 * 单位当前资金情况表dao
 * 
 * @author
 * @date 2012-11-05
 */
public class DisCurrentMoneyDao extends EntityDao<DisCurrentMoney> implements IDisCurrentMoneyDao {

	@Override
	public Class<DisCurrentMoney> getEntityClass() {
		return DisCurrentMoney.class;
	}

	public void updateOfOrgan(String receiveOrganCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "DIS_COMPUTE_ORGAN_MONEY");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "organ_code");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		Object object = null;
		map.put("parameterValue_1", receiveOrganCode);
		object = procduce.call(map).get("results");
	}
}