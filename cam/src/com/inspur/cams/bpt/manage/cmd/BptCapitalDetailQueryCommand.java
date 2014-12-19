package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCapitalDetailQueryCommand
 * @description:
 * @author:
 * @since:2011-05-28
 * @version:1.0
*/
public class BptCapitalDetailQueryCommand extends BaseQueryCommand{
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	private BptCapitalDetailDao detailDao = (BptCapitalDetailDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao");

	/**
	 * 查询名单人员{伤残、三属、老复员、带病回乡、两参}
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDisabilityDataSet(pset);
		return ds;
	}
	/**
	 * 查询抚恤金发放明细[伤残、三属、复员军人、生活补助费]
	 */
	public DataSet queryYearDataSet() {
		ParameterSet pset = getParameterSet();
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		return detailDao.query(pset);
	}
	/**
	 * 查询全部数据
	 * @return
	 */
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		BptCapitalDetailDao dao = (BptCapitalDetailDao) DaoFactory
				.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao");
		return dao.query(pset);
	}
	
	/**
	 * 查询导出数据
	 */
	public DataSet queryExportData(){
		ParameterSet pset = getParameterSet();
		DataSet ds = detailDao.queryExportData(pset);
		return ds;
	}
	
	/**
	 * 查询三属补助抚恤数据
	 * @return
	 *//*
	public DataSet queryGeneraDataSet(){
		ParameterSet pset = getParameterSet();
		return service.queryGeneraDataSet(pset);
	}
	*//**
	 * 查询定期定量生活补助抚恤数据
	 * @return
	 *//*
	public DataSet queryLifeDataSet(){
		ParameterSet pset = getParameterSet();
		return service.queryLifeDataSet(pset);
	}*/
	
}
