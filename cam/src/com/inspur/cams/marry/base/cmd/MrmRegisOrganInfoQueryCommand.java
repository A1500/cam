package com.inspur.cams.marry.base.cmd;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;

/**
 * @title:MrmRegisOrganInfoQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
 */
public class MrmRegisOrganInfoQueryCommand extends BaseQueryCommand {

	private IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
			IMrmRegisOrganInfoDomain.class,
			"MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");

	public DataSet execute() {
		ParameterSet ps = getParameterSet();
		IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
				IMrmRegisOrganInfoDomain.class,
				"MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
		return domain.query(ps);
	}

	public DataSet getOrgan() {
		ParameterSet ps = getParameterSet();
		IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
				IMrmRegisOrganInfoDomain.class,
				"MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
		String id = (String) ps.getParameter("id") == null ? "" : (String) ps
				.getParameter("id");
		String subId = "";
		if (!"".equals(id) && id.length() == 12 && id.endsWith("0000000000")) {
			subId = id.substring(0, 2);
		}else if (!"".equals(id) && id.length() == 12 && id.endsWith("00000000")) {
			subId = id.substring(0, 4);
		}else if (!"".equals(id) && id.length() == 12 && id.endsWith("000000")) {
			subId = id.substring(0, 6);
		}
		ParameterSet search = new ParameterSet();
		search.setParameter("REGION_CODE@rlike", subId);
		search.setParameter("VALID_FLAG@=", "1");
		search.setParameter("sort", "DEPT_CODE");
		search.setParameter("dir", "asc");
		DataSet ds = domain.query(search);
		return ds;
	}

	public DataSet getOrganInfo() {
		ParameterSet ps = getParameterSet();
		return domain.getOrganInfo(ps);
	}

	/**
	 * 查询婚姻登记处列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryOrganInfoList() {
		ParameterSet pset = getParameterSet();
		DataSet ds = domain.queryOrganInfoList(pset);
		Record record = new Record();
		BigDecimal bigDecimal;
		for(int i=0;i<ds.getCount();i++) {
			record = ds.getRecord(i);
			bigDecimal = domain.getCountArea((String)record.get("DEPT_CODE"));
			record.set("areaCount", bigDecimal);
		}
		return ds;
	} 
	/**
	 * 查询所有带等级的登记处
	 * @return
	 */
	public DataSet queryLevelOrgan(){
		ParameterSet pset = getParameterSet();
		return domain.queryLevelOrgan(pset);
	}
}
