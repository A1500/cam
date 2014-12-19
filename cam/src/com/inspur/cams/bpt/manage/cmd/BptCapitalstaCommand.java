package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;
import com.inspur.cams.bpt.capital.domain.IBptCapitalstaDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:资金发放标准
 * @description:资金发放标准
*/           
public class BptCapitalstaCommand extends BaseAjaxCommand{
	private BptCapitalstaDao dao = (BptCapitalstaDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao");
	private IBptCapitalstaDomain standardService = ScaComponentFactory.getService(IBptCapitalstaDomain.class,"bptCapitalstaDomain/bptCapitalstaDomain");
	
	/**
	 * 标准增加、修改
	 */
	@Trans
	public void save(){
		String startDate = (String)getParameter("startDate");
		String organCode = (String)getParameter("organCode");
		String type = (String)getParameter("type");
		Record[] records = (Record[]) getParameter("records");
		String method = (String)getParameter("method");
		if("insert".equals(method)){
			//获取日期前一天
			List datelist = dao.getBeforeDate(startDate);
			Map temp =(Map) datelist.get(0);
			String beforeDate = (String) temp.get("BEFOREDATE");
			ParameterSet pset=  new ParameterSet();
			pset.setParameter("organId",organCode);
			pset.setParameter("type",type);
			DataSet ds =dao.queryDs(pset);
			//如果该区县存在，先修改之前startDate最大的结束日期，并将保存现有标准，反而，直接保存
			if(ds.getCount() !=0){
			    for(int j= 0;j<ds.getCount();j++){
			    	Record  rd =ds.getRecord(j);
			    	ParameterSet params = new ParameterSet();
			    	params.setParameter("id", rd.get("ID"));
			    	params.setParameter("endDate", beforeDate);
			    	dao.udpateEndDate(params);
			    }
			}
		}
		List<BptCapitalsta> list = new ArrayList<BptCapitalsta>();
		for (int i = 0; i < records.length; i++) {
			BptCapitalsta dataBean = (BptCapitalsta) records[i].toBean(BptCapitalsta.class);
			if(dataBean.isNew()){
				dataBean.setId(IdHelp.getUUID32());
				dataBean.setStandardsCounties(organCode);
				dataBean.setStartDate(startDate);
				dataBean.setEndDate("");
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
				dataBean.setType(type);
			}
			if(dataBean.isModified()){
				dataBean.setModId(BspUtil.getEmpOrganId());
				dataBean.setModTime(DateUtil.getTime());
			}
			list.add(dataBean);
		}
		dao.save(list);
	}
	
	/**
	 * 删除明细数据
	 */
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	
	/**
	 * 删除列表中的数据
	 */
	@Trans
	public void deleteList() {
		String[] counties=(String[]) getParameter("counties");
		String[] startDates=(String[]) getParameter("startDates");
		String type =(String) getParameter("type");
		for(int i=0;i<counties.length && i<startDates.length;i++){
			ParameterSet pset =new ParameterSet();
			pset.setParameter("countie", counties[i]);
			pset.setParameter("start", startDates[i]);
			pset.setParameter("type", type);
			standardService.deleteStandard(pset);
		}
	}
	
	@Trans
	public void getMaxDate(){
		ParameterSet pset =this.getParameterSet();
		pset.setParameter("type", pset.get("type"));
		pset.setParameter("organCode", pset.get("organCode"));
		DataSet ds =dao.getMaxDate(pset);
		if(ds.getCount() !=0){
			this.setReturn("maxDate", ds.getRecord(0).get("START_DATE"));
		}
	}
	
}