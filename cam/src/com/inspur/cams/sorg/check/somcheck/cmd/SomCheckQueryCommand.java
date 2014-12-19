package com.inspur.cams.sorg.check.somcheck.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;

/**
 * @title:SomCheckQueryCommand
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
public class SomCheckQueryCommand extends BaseQueryCommand{
	private SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
	private SomOrganDao somOrganDao = (SomOrganDao) DaoFactory.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dao.query(pset);
	}
	/**
	 * 查询年检历史
	 * @return
	 */
	public DataSet queryCheckHis() {
		ParameterSet pset = new ParameterSet();
		String sorgCode = (String) getParameter("SORG_CODE");
		String sorgType = (String) getParameter("SORG_TYPE");
		pset.setParameter("SORG_CODE", sorgCode);
		pset.setParameter("SORG_TYPE", sorgType);
		DataSet somOrganDS=somOrganDao.query(pset);
		int i;
		int sysUseYear=2013-1;
		int curCheckYear=Integer.parseInt(DateUtil.getYear())-1;
		if(somOrganDS==null||somOrganDS.getCount()<1){
			return null;
		}
		
		SomOrgan somOrgan=(SomOrgan) somOrganDS.getRecord(0).toBean(SomOrgan.class);
		String cnName=somOrgan.getCnName();
		i=sysUseYear;

		pset.setParameter("BATCH_YEAR@>=", i);
		DataSet somCheckDS=dao.query(pset);
		List<SomCheck> somCheckList=new ArrayList<SomCheck>();
		List checkYearList=new ArrayList();
		if(somCheckDS!=null){
			for (int j = 0; j < somCheckDS.getCount(); j++) {
				SomCheck somCheck=(SomCheck) somCheckDS.getRecord(j).toBean(SomCheck.class);
				int batchYear=Integer.parseInt(somCheck.getBatchYear());
				checkYearList.add(batchYear);			
				somCheckList.add(somCheck);
			}
		}
		List yearList=new ArrayList();
		for (; i <= curCheckYear; i++) {
			yearList.add(i);			
		}
		yearList.removeAll(checkYearList);
		for (int j = 0; j < yearList.size(); j++) {
			Record record=new Record();
			record.set("cnName", cnName);
			record.set("sorgCode", sorgCode);
			record.set("sorgType", sorgType);
			record.set("batchYear", yearList.get(j));
			somCheckDS.add(record);
		}
		return somCheckDS;
	}
	
	/**
	 * 查询未年检的社会组织
	 * @return
	 */
	public DataSet queryNoCheck(){
		ParameterSet pset = getParameterSet();
		SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
		return dao.queryNoCheck(pset);
	}
	
	/**
	 * 查询未年检并已经行政处罚的社会组织
	 * @return
	 */
	public DataSet queryNoCheckPenaltied(){
		ParameterSet pset = getParameterSet();
		SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
		return dao.queryNoCheckPenaltied(pset);
	}
	/**
	 * 查询年检核对列表
	 * @return
	 */
	public DataSet queryFlowList(){
		ParameterSet pset = getParameterSet();
		SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
		return dao.queryFlowList(pset);
	}
}
