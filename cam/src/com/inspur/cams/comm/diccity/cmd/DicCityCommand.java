package com.inspur.cams.comm.diccity.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * 行政区划command
 * 
 * @author zhanghui
 * 
 */
public class DicCityCommand extends BaseAjaxCommand {

	DicCityDao dao = (DicCityDao) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	
	
	/**
	 * 查询行政区划名称
	 */
	public void findOrganName() {
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			String organName = ((DicCity)ds.getRecord(0).toBean(DicCity.class)).getFullName();
			setReturn("organName", organName);
		}
	}
	
	/**
	 * 带有权限的获得根节点（殡葬系统）
	 */
	public void getRootForHelp(){
		ParameterSet pset=getParameterSet();
		String organArea=pset.getParameter("organArea")==null?"":(String)pset.getParameter("organArea");
		pset.clear();
		pset.setParameter("ID", organArea);
		DataSet ds=dao.query(pset);
		int num=ds.getCount();
		DicCity localBean=new DicCity();
		if(num>0){
			localBean=(DicCity)ds.getRecord(0).toBean(DicCity.class);
		}else{
			localBean.setId("370000000000");
			localBean.setName("山东省");
			localBean.setLeve("0");
		}
		Record localRecord=new Record();
		localRecord.fromBean(localBean);
		setReturn("rootRecord",localRecord);
	}
	
	/**
	 * 查询organInfoById
	 * @return
	 */
	public void getOrganInfoById() {
		ParameterSet ps = getParameterSet();
		ps.setParameter("sort", "id");
		ps.setParameter("dir", "asc");
		String id = (String) ps.getParameter("id");
		setReturn("fOrganName",dao.getOrganNameById(id));
	}
}
