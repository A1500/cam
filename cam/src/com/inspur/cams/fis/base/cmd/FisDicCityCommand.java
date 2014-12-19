package com.inspur.cams.fis.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.fis.base.dao.jdbc.FisDicCityDao;
import com.inspur.cams.fis.base.data.FisDicCity;

/**
 * @title:FisDicCityCommand
 * @description:
 * @author:
 * @since:2012-02-10
 * @version:1.0
*/
public class FisDicCityCommand extends BaseAjaxCommand{
	private FisDicCityDao dao = (FisDicCityDao) DaoFactory
			.getDao("com.inspur.cams.fis.base.dao.jdbc.FisDicCityDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		String ups = (String) getParameter("ups");
		FisDicCity dataBean=(FisDicCity)record.toBean(FisDicCity.class);
		dataBean.setUps(ups);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisDicCity dataBean=(FisDicCity)record.toBean(FisDicCity.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisDicCity> list = new ArrayList<FisDicCity>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisDicCity dataBean = (FisDicCity) records[i].toBean(FisDicCity.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	/**
	* @Title: getRootForHelp
	* @Description: TODO(这里用一句话描述这个方法的作用)
	* @param     
	* @return void  
	* @throws
	 */
	public void getRootForHelp(){
		ParameterSet pset=getParameterSet();
		String rootId=pset.getParameter("rootId")==null?"":(String)pset.getParameter("rootId");
		FisDicCity localBean=new FisDicCity();
		if(rootId.equals("rootId")){
			localBean.setId("rootId");
			localBean.setName("中国");
			localBean.setFullName("中国");
			localBean.setFlag("");
			localBean.setLeve("-1");
			localBean.setUps("");
		}else{
			pset.clear();
			pset.setParameter("ID", rootId);
			DataSet ds=dao.query(pset);
			if(ds.getCount()>0){
				localBean=(FisDicCity)ds.getRecord(0).toBean(FisDicCity.class);
			}else{
				localBean.setId("rootId");
				localBean.setName("中国");
				localBean.setFullName("中国");
				localBean.setFlag("");
				localBean.setLeve("-1");
				localBean.setUps("");
			}
		}
		Record localRecord=new Record();
		localRecord.fromBean(localBean);
		setReturn("rootRecord",localRecord);
	}
}
