package com.inspur.cams.drel.rpt.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao;
import com.inspur.cams.drel.rpt.data.RptCountrymedicalassistance;

/**
 * @title:农村医疗救助工作情况增加修改Cmd
 * @description:
 * @author:yangliangliang
 * @since:2011-06-22
 * @version:1.0
*/
public class RptCountrymedicalassistanceCommand extends BaseAjaxCommand{
	private RptCountrymedicalassistanceDao dao = (RptCountrymedicalassistanceDao) DaoFactory
			.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
	/**
	 * 查询农村医疗救助工作情况
	 */
	@SuppressWarnings("unchecked")
	public void queryCountrymedicalassistance() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCountrymedicalassistance> dao = (EntityDao<RptCountrymedicalassistance>) DaoFactory
				.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
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
	 * 查询农村医疗救助工作情况
	 */
	@SuppressWarnings("unchecked")
	public void queryCountrymedicalassistanceForSummary() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCountrymedicalassistance> dao = (EntityDao<RptCountrymedicalassistance>) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
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
	 * 查询农村医疗救助工作情况修改
	 */
	@SuppressWarnings("unchecked")
	public void queryCountrymedicalassistanceForupdate() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCountrymedicalassistance> dao = (EntityDao<RptCountrymedicalassistance>) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
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
	 * 农村医疗救助工作情况上报 将是否已上报标志修改为1
	 */
	@SuppressWarnings("unchecked")
	public void report() {
		ParameterSet pset = getParameterSet();
		EntityDao<RptCountrymedicalassistance> dao = (EntityDao<RptCountrymedicalassistance>) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("reported") != null) {
					if("1".equals(ds.getRecordSet().get(0).get("reported").toString())) {//已经上报过
						setReturn("message", "已经上报的数据不能再进行上报！");
					}else {//未上报
						RptCountrymedicalassistance rptCountrymedicalassistance = dao.get(ds.getRecordSet().get(0).get("id"));
						rptCountrymedicalassistance.setReported("1");
						dao.update(rptCountrymedicalassistance);
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
	
	/**
	 * 农村医疗救助工作情况的添加
	 */
	public void insert() {
		Record record = (Record) getParameter("record");
		RptCountrymedicalassistance dataBean=(RptCountrymedicalassistance)record.toBean(RptCountrymedicalassistance.class);
		dao.insert(dataBean);
	}
	/**
	 * 农村医疗救助工作情况的修改
	 */
	public void update() {
		Record record = (Record) getParameter("record");
		RptCountrymedicalassistance dataBean=(RptCountrymedicalassistance)record.toBean(RptCountrymedicalassistance.class);
		dao.update(dataBean);
	}
	/**
	 * 农村医疗救助工作情况的删除
	 */
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	/**
	 * 农村医疗救助工作情况的保存
	 */
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<RptCountrymedicalassistance> list = new ArrayList<RptCountrymedicalassistance>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			RptCountrymedicalassistance dataBean = (RptCountrymedicalassistance) records[i].toBean(RptCountrymedicalassistance.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	/**
	 * 农村医疗救助工作情况的回退
	 */
	@SuppressWarnings("unchecked")
	public void forRetreat(){
		ParameterSet pset = getParameterSet();
		EntityDao<RptCountrymedicalassistance> dao = (EntityDao<RptCountrymedicalassistance>) DaoFactory
		.getDao("com.inspur.cams.drel.rpt.dao.RptCountrymedicalassistanceDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0) {
			if(ds.getCount() == 1) {
				if(ds.getRecordSet().get(0).get("reported") != null) {
					RptCountrymedicalassistance rptCountrymedicalassistance = dao.get(ds.getRecordSet().get(0).get("id"));
					if("0".equals(rptCountrymedicalassistance.getReported())){
						setReturn("message", "该数据没有被上报或已经被回退！");	
						return;
					}
					rptCountrymedicalassistance.setReported("0");
					dao.update(rptCountrymedicalassistance);
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
