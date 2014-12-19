package com.inspur.cams.comm.informUtil;


import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

/**
 * @title:
 * @description:
 * @author:
 * @since:2009-12-01
 * @version:1.0
 */
public class struQueryCommand extends BaseAjaxCommand {

	@SuppressWarnings("unchecked")
	/**
	 * 查询单条信息
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String struOrganId = (String)pset.getParameter("struOrganId");

		StruInfoQueryDa dao = (StruInfoQueryDa) DaoFactory
		.getDao("com.inspur.cams.comm.informUtil.StruInfoQueryDa");

		 DataSet ds=dao.queryStruByOrganId(struOrganId);

		 Record record=ds.getRecord(0);

		 String stru_id=(String)record.get("STRU_ID");

		 setReturn("struId", stru_id);
		return ds;
	}
}
