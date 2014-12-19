package com.inspur.cams.sorg.online.base.cmd;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.online.base.data.SomApplyOnline;

/**
 * @title:SomApplyOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomApplyOnlineQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomApplyOnline> dao = (EntityDao<SomApplyOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomApplyOnlineDao");
		return dao.query(pset);
	}
	/**
	 * 查询待办
	 * @return
	 */
	public DataSet queryHasAcceptStatus() {
		ParameterSet pset = getParameterSet();
		String taskCode = (String)pset.getParameter("TASK_CODE");
		String sorgName = (String)pset.getParameter("SORG_NAME");
		String createOrgan = (String)pset.getParameter("CREATE_ORGAN");
		String applyType = (String)pset.getParameter("APPLY_TYPE");
		String sorgType = (String)pset.getParameter("SORG_TYPE");
		String onlineStatus = (String)pset.getParameter("ONLINE_STATUS");
		//pset.clear();
		if(taskCode != null){
			pset.setParameter("TASK_CODE", taskCode);
		}
		if(sorgName != null){
			pset.setParameter("SORG_NAME@LIKE", "%"+sorgName+"%");
		}
		if(createOrgan != null){
			pset.setParameter("CREATE_ORGAN", createOrgan);
		}
		if(applyType != null){
			pset.setParameter("APPLY_TYPE", applyType);
		}
		if(sorgType != null){
			pset.setParameter("SORG_TYPE", sorgType);
		}
		if(StringUtils.isNotEmpty(onlineStatus)){
			pset.setParameter("ONLINE_STATUS", onlineStatus);
		}else{
			pset.setParameter("ONLINE_STATUS@IN", "1,2");
		}
		DataSet returnDataSet =new DataSet();
		EntityDao<SomApplyOnline> dao = (EntityDao<SomApplyOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomApplyOnlineDao");
		EntityDao<SomApply> daoApply = (EntityDao<SomApply>) DaoFactory
		.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomApplyDao");
		//根据taskcode查询apply表是否已经存在，存在说明已经受理了
		DataSet DataSet = dao.query(pset);
		/*for(int i=0;i<DataSet.getCount();i++){
			SomApplyOnline somApplyOnline = (SomApplyOnline) DataSet.getRecord(i).toBean(SomApplyOnline.class);
			ParameterSet psetQueryApply = new ParameterSet();
			psetQueryApply.setParameter("TASK_CODE", somApplyOnline.getTaskCode());
		//	psetQueryApply.setParameter("APPLY_TYPE", applyType);
			DataSet DataSetApply = daoApply.query(psetQueryApply);
			if(DataSetApply.getCount()>0){
				somApplyOnline.setAcceptSatus("已受理");
			}else{
				somApplyOnline.setAcceptSatus("未受理");
				returnDataSet.addRecord(somApplyOnline);
			}
			
		}*/
		return DataSet;
	}
	/**
	 * 查询已办
	 * @return
	 */
	public DataSet queryHasAcceptStatusYiBan() {
		ParameterSet pset = getParameterSet();
		String taskCode = (String)pset.getParameter("TASK_CODE");
		String sorgName = (String)pset.getParameter("SORG_NAME");
		String createOrgan = (String)pset.getParameter("CREATE_ORGAN");
		String applyType = (String)pset.getParameter("APPLY_TYPE");
		String sorgType = (String)pset.getParameter("SORG_TYPE");
		pset.clear();
		if(taskCode != null){
			pset.setParameter("TASK_CODE", taskCode);
		}
		if(sorgName != null){
			pset.setParameter("SORG_NAME@LIKE", "%"+sorgName+"%");
		}
		if(createOrgan != null){
			pset.setParameter("CREATE_ORGAN", createOrgan);
		}
		if(applyType != null){
			pset.setParameter("APPLY_TYPE", applyType);
		}
		if(sorgType != null){
			pset.setParameter("SORG_TYPE", sorgType);
		}
		pset.setParameter("ONLINE_STATUS@IN", "3,4");//已办列表默认加载状态为3，4的
		DataSet returnDataSet =new DataSet();
		EntityDao<SomApplyOnline> dao = (EntityDao<SomApplyOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomApplyOnlineDao");
		EntityDao<SomApply> daoApply = (EntityDao<SomApply>) DaoFactory
		.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomApplyDao");
		//根据taskcode查询apply表是否已经存在，存在说明已经受理了
		DataSet DataSet = dao.query(pset);
		/*for(int i=0;i<DataSet.getCount();i++){
			SomApplyOnline somApplyOnline = (SomApplyOnline) DataSet.getRecord(i).toBean(SomApplyOnline.class);
			ParameterSet psetQueryApply = new ParameterSet();
			psetQueryApply.setParameter("TASK_CODE", somApplyOnline.getTaskCode());
		//	psetQueryApply.setParameter("APPLY_TYPE", applyType);
			DataSet DataSetApply = daoApply.query(psetQueryApply);
			if(DataSetApply.getCount()>0){
				somApplyOnline.setAcceptSatus("已受理");
				returnDataSet.addRecord(somApplyOnline);
			}else{
				somApplyOnline.setAcceptSatus("未受理");
			}
		}*/
		return DataSet;
	}
}
