package com.inspur.cams.sorg.jxcheck.somjxcheck.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao;

/**
 * @title:SomJxCheckQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheck> dao = (EntityDao<SomJxCheck>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheck> dao = (EntityDao<SomJxCheck>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
	/**
	 * 查询未年检的社会组织
	 * @return
	 */
	public DataSet queryNoCheck(){
		ParameterSet pset = getParameterSet();
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		return dao.queryNoCheck(pset);
	}
//##########################################         社团年检汇报               ################################################	
	@Trans
	public DataSet queryGroupCheckReport(){
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		ParameterSet pset = getParameterSet();
		String ifGridAll = StrUtil.n2b((String)pset.getParameter("ifGridAll"));
		if(ifGridAll.equals("1")){
			pset.remove("ifGridAll");
			String year = (String)pset.getParameter("year");
			//可能是loushang版本问题pset中limit默认为10，只能查询出来10条，此处重置limit为10000
			pset.setParameter("limit", 10000);
			DataSet dsTemp = dao.query(pset);
			String taskCodes = "";
			for(int i=0;i<dsTemp.getCount();i++){
				taskCodes+=dsTemp.getRecord(i).get("taskCode")+",";
			}
			taskCodes=taskCodes.substring(0,taskCodes.length()-1);
			ParameterSet psetGridQuery = new ParameterSet();
			psetGridQuery.setParameter("TASK_CODE", taskCodes);
			psetGridQuery.setParameter("CHECK_YEAR", year);
			return dao.queryGroupCheckReport(psetGridQuery);
		}else{
			return  dao.queryGroupCheckReport(pset);
		}
	}
//##########################################         民非年检汇报               ################################################	
	@Trans
	public DataSet queryUngovCheckReport(){
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		ParameterSet pset = getParameterSet();
		String ifGridAll = StrUtil.n2b((String)pset.getParameter("ifGridAll"));
		if(ifGridAll.equals("1")){
			pset.remove("ifGridAll");
			String year = (String)pset.getParameter("year");
			pset.setParameter("limit", 10000);
			DataSet dsTemp = dao.query(pset);
			String taskCodes = "";
			for(int i=0;i<dsTemp.getCount();i++){
				taskCodes+=dsTemp.getRecord(i).get("taskCode")+",";
			}
			taskCodes=taskCodes.substring(0,taskCodes.length()-1);
			ParameterSet psetGridQuery = new ParameterSet();
			psetGridQuery.setParameter("TASK_CODE", taskCodes);
			psetGridQuery.setParameter("CHECK_YEAR", year);
			return dao.queryUngovCheckReport(psetGridQuery);
		}else{
			return  dao.queryUngovCheckReport(pset);
		}
	}
//##########################################         基金会年检汇报               ################################################	
	@Trans
	public DataSet queryFundCheckReport(){
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		ParameterSet pset = getParameterSet();
		String ifGridAll = StrUtil.n2b((String)pset.getParameter("ifGridAll"));
		if(ifGridAll.equals("1")){
			pset.remove("ifGridAll");
			String year = (String)pset.getParameter("year");
			pset.setParameter("limit", 10000);
			DataSet dsTemp = dao.query(pset);
			String taskCodes = "";
			for(int i=0;i<dsTemp.getCount();i++){
				taskCodes+=dsTemp.getRecord(i).get("taskCode")+",";
			}
			taskCodes=taskCodes.substring(0,taskCodes.length()-1);
			ParameterSet psetGridQuery = new ParameterSet();
			psetGridQuery.setParameter("TASK_CODE", taskCodes);
			psetGridQuery.setParameter("CHECK_YEAR", year);
			return dao.queryFundCheckReport(psetGridQuery);
		}else{
			return  dao.queryFundCheckReport(pset);
		}
	}
//##########################################         年检汇报基本数据分析               ################################################	
	@Trans
	public DataSet queryCheckBaseAnalyse(){
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.queryCheckBaseAnalyse(pset);
		return ds;
	}
//##########################################         年检汇报常用数据分析               ################################################	
	@Trans
	public DataSet queryCheckAnalyse(){
		SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.queryCheckAnalyse(pset);
		return ds;
	}
}
