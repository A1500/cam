package com.inspur.cams.welfare.welfarecorp.apply.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitWorkerQueryDomain;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitWorkerQueryCmd extends BaseAjaxCommand {
	private IUnitWorkerQueryDomain unitWorkerQueryDomain = ScaComponentFactory
			.getService(IUnitWorkerQueryDomain.class,
					"unitWorkerQueryDomain/unitWorkerQueryDomain");

	// 查询职工合计信息
	public DataSet queryUnitWorkerSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = unitWorkerQueryDomain.queryUnitWorkerSum(pset);
		if (ds.getCount() > 0) {
			RecordSet rs = ds.getRecordSet();
			setReturn("totalNum", rs.get(0).get("TOTAL_NUM"));
			setReturn("disNum", rs.get(0).get("DIS_NUM"));
			setReturn("noProNum", rs.get(0).get("NO_PRO_NUM"));
			setReturn("proNum", rs.get(0).get("PRO_NUM"));
		}

		return ds;
	}

	// 查询残疾职工明细
	public DataSet queryUnitWorkerDisability() {
		ParameterSet pset = getParameterSet();
		DataSet ds = unitWorkerQueryDomain.queryUnitWorkerDisability(pset);
		if (ds.getCount() > 0) {
			RecordSet rs = ds.getRecordSet();
			setReturn("slcj", rs.get(0).get("SLCJ"));
			setReturn("tlcj", rs.get(0).get("TLCJ"));
			setReturn("yycj", rs.get(0).get("YYCJ"));
			setReturn("ztcj", rs.get(0).get("ZTCJ"));
			setReturn("zlcj", rs.get(0).get("ZLCJ"));
			setReturn("jscj", rs.get(0).get("JSCJ"));
			setReturn("dccj", rs.get(0).get("DCCJ"));
			setReturn("qtcj", rs.get(0).get("QTCJ"));
			setReturn("zljscj", rs.get(0).get("ZLJSCJ"));
		}

		return ds;
	}
}
