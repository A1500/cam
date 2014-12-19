package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:资金发放标准查询
 * @description:资金发放标准查询
 * @author:
 * @since:2011-05-23
 * @version:1.0
*/
public class BptCapitalstaQueryCommand extends BaseQueryCommand{
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	private BptCapitalstaDao dao = (BptCapitalstaDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao");
	
	/**
	 * 查询新增和修改标准DataSet
	 */
	public DataSet standardDatasetQuery(){
		ParameterSet pset = getParameterSet();
		String method = (String)pset.getParameter("method");
		if("insert".equals(method)){
			String newestStartDate = dao.querynewestStartDate(pset);
			if(newestStartDate!=null&&!("".equals(newestStartDate))){
				pset.setParameter("START_DATE",newestStartDate);
			}else{
				newestStartDate = "1900-01-01";
				pset.setParameter("START_DATE",newestStartDate);
			}
			pset.remove("method");
		}
		return dao.query(pset);
	}
	
	/**
	 * 资金发放标准列表查询页面
	 * @return
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds =  service.queryDataSet(pset);
		return this.queryDataSet(ds);
	}
	
	/**
	 * 公共方法 param DataSet
	 */
	public DataSet queryDataSet(DataSet ds){
		for(int i = 0;i<ds.getCount();i++){
			Record rd =ds.getRecord(i);
			ParameterSet param = new ParameterSet();
			param.setParameter("personNo", rd.get("REG_ID"));
			DataSet ds1 = dao.getPerson(param);
			rd.set("REG_ID", ds1.getRecord(0).get("ORGAN_NAME"));
		}
		return ds;
	}
	
	/**
	 * 公共方法 param DataSet修改、明细页面
	 */
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		BptCapitalstaDao dao = (BptCapitalstaDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao");
		DataSet ds =dao.query(pset);
		ds.addField("standardsName");
		Record rd =ds.getRecord(0);
		ParameterSet param=  new ParameterSet();
		param.setParameter("counties", rd.get("standardsCounties"));
		DataSet ds1 = dao.getCounties(param);
		String counties =(String) ds1.getRecord(0).get("ORGAN_NAME");
		for(int i = 0;i<ds.getCount();i++){
			Record newRd = ds.getRecord(i);
			newRd.set("standardsName", counties);
		}
	    return ds;
	}
}
