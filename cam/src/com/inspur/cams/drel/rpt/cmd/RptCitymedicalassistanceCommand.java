package com.inspur.cams.drel.rpt.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.rpt.dao.*;
import com.inspur.cams.drel.rpt.data.RptCitymedicalassistance;
import com.inspur.cams.drel.rpt.data.RptCountrymedicalassistance;

/**
 * @title:RptCitymedicalassistanceCommand
 * @description:城市医疗救助工作情况Cmd类
 * @author:fujw
 * @since:2011-06-14
 * @version:1.0
*/
public class RptCitymedicalassistanceCommand extends BaseAjaxCommand{
	private RptCitymedicalassistanceDao dao = (RptCitymedicalassistanceDao) DaoFactory
			.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
	
	/**
	 * 查询城市医疗救助工作情况
	 */
	@SuppressWarnings("unchecked")
	public void queryCitymedicalassistance() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCitymedicalassistance> dao = (EntityDao<RptCitymedicalassistance>) DaoFactory
				.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("id") != null && ds.getRecordSet().get(0).get("reported") != null) {
					if("1".equals(ds.getRecordSet().get(0).get("reported").toString())) {//已上报的数据不能再进行修改
						setReturn("message", "已上报的数据不能再进行修改！");
						setReturn("id", ds.getRecordSet().get(0).get("id").toString());//将id传回前台
					}else {//返回修改数据的主键id
						setReturn("id", ds.getRecordSet().get(0).get("id").toString());//将id传回前台
						setReturn("message", "数据未上报");//前台暂不使用此提示信息
					}
				}
			}else {
				setReturn("message", "存在错误数据！");
			}					
		}
	}
	
	/**
	 * 查询城市医疗救助工作情况
	 */
	@SuppressWarnings("unchecked")
	public void queryCitymedicalassistanceForSummary() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCitymedicalassistance> dao = (EntityDao<RptCitymedicalassistance>) DaoFactory
				.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("id") != null && ds.getRecordSet().get(0).get("reported") != null) {
					setReturn("id", ds.getRecordSet().get(0).get("id").toString());//将id传回前台
					setReturn("message", "汇总修改！");//设置message是为了转向汇总修改的报表文件
				}
			}else {
				setReturn("message", "存在错误数据！");
			}
		}
	}
	
	/**
	 * 查询城市医疗救助工作情况修改
	 */
	@SuppressWarnings("unchecked")
	public void queryCitymedicalassistanceForupdate() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCitymedicalassistance> dao = (EntityDao<RptCitymedicalassistance>) DaoFactory
				.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("id") != null && ds.getRecordSet().get(0).get("reported") != null) {
					if(!"1".equals(ds.getRecordSet().get(0).get("reported").toString())) {//未上报的数据不能进行修改
						setReturn("message", "未上报的数据不能进行修改！");
					}else {//返回修改数据的主键id
						setReturn("id", ds.getRecordSet().get(0).get("id").toString());//将id传回前台
					}
				}
			}else {
				setReturn("message", "存在错误数据！");
			}					
		}else{
			setReturn("message", "不存在该单位此年份及季度的数据！");
		}
	}
	
	/**
	 * 城市医疗救助工作情况上报 将是否已上报标志修改为1
	 */
	@SuppressWarnings("unchecked")
	public void report() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCitymedicalassistance> dao = (EntityDao<RptCitymedicalassistance>) DaoFactory
				.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("reported") != null) {
					if("1".equals(ds.getRecordSet().get(0).get("reported").toString())) {//已经上报过
						setReturn("message", "已经上报的数据不能再进行上报！");
					}else {//未上报
						RptCitymedicalassistance rptCitymedicalassistance = dao.get(ds.getRecordSet().get(0).get("id"));
						rptCitymedicalassistance.setReported("1");
						dao.update(rptCitymedicalassistance);
						setReturn("message", "上报成功！");
					}
				}else {
					setReturn("message", "是否已上报的属性值不正确！");
				}
				
			}else {
				setReturn("message", "存在错误数据！");
			}					
		}
	}
	
	public void insert() {
		Record record = (Record) getParameter("record");
		RptCitymedicalassistance dataBean=(RptCitymedicalassistance)record.toBean(RptCitymedicalassistance.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		RptCitymedicalassistance dataBean=(RptCitymedicalassistance)record.toBean(RptCitymedicalassistance.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<RptCitymedicalassistance> list = new ArrayList<RptCitymedicalassistance>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			RptCitymedicalassistance dataBean = (RptCitymedicalassistance) records[i].toBean(RptCitymedicalassistance.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	/**
	 * 回退功能
	 */
	@SuppressWarnings("unchecked")
	public void forRetreat(){
		ParameterSet pset = getParameterSet();
		EntityDao<RptCitymedicalassistance> dao = (EntityDao<RptCitymedicalassistance>) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCitymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("reported") != null) {
					RptCitymedicalassistance RptCitymedicalassistance = dao.get(ds.getRecordSet().get(0).get("id"));
					if("0".equals(RptCitymedicalassistance.getReported())){
						setReturn("message", "该数据没有被上报或已经被回退！");	
						return;
					}
					RptCitymedicalassistance.setReported("0");
					dao.update(RptCitymedicalassistance);
					setReturn("message", "回退成功！");	
				}else {
					setReturn("message", "未找到所对应的报表！");
				}	
			}else {
				setReturn("message", "存在错误数据！");
			}					
		}else{
			setReturn("message", "未找到所对应的报表！");
		}
	}
}
