package com.inspur.cams.marry.base.cmd;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.dao.*;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.domain.IMrmBasePersonDomain;
import com.inspur.cams.marry.base.domain.IMrmQualificationExamDomain;

/**
 * @title:MrmBasePersonQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
 */
public class MrmBasePersonQueryCommand extends BaseQueryCommand {

	IMrmBasePersonDomain iMrmBasePersonDomain = ScaComponentFactory.getService(
			IMrmBasePersonDomain.class,
			"MrmBasePersonDomain/MrmBasePersonDomain");
	
	IMrmQualificationExamDomain iMrmQualificationExamDomain = ScaComponentFactory
	.getService(IMrmQualificationExamDomain.class,
			"MrmQualificationExamDomain/MrmQualificationExamDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return iMrmBasePersonDomain.query(pset);
	}
	
	/**
	 * 查询登记人员报名信息
	 */
	public DataSet examApplyDataSet(){
		ParameterSet pSet = getParameterSet();
		
//		pSet.setParameter("deptId", getParameter("deptId").toString());
//		System.out.println(iMrmBasePersonDomain.examApplyDataSet(pSet).getCount());
		DataSet ds = iMrmBasePersonDomain.examApplyDataSet(pSet);
//		DataSet dataSet = new DataSet();
	    Date dt = new Date();
	    //最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	    int nowYears = Integer.parseInt(sdf.format(dt));
		for (int i = 0; i < ds.getCount(); i++) {
			//Record record = ds.getRecord(i);
			String personId = (String) ds.getRecord(i).get("PERSON_ID");
			ParameterSet psetExam = new ParameterSet();
			psetExam.setParameter("personId", personId);
			if ("01".equals(pSet.getParameter("bzyCode"))) {
				psetExam.setParameter("ksSign", "0");//登记员
			}else if ("02".equals(pSet.getParameter("bzyCode"))) {
				psetExam.setParameter("ksSign", "1");//颁证员
			}
			
			psetExam.setParameter("limit", 12);
			DataSet dataExam = iMrmQualificationExamDomain.queryPersonExam(psetExam);
			int giveYear = 0;
			if(dataExam.getCount()>0){
				if (dataExam.getRecord(0).get("GIVE_OUT_TIME") != null && !"".equals(dataExam.getRecord(0).get("GIVE_OUT_TIME"))) {
					giveYear = Integer.parseInt(dataExam.getRecord(0).get("GIVE_OUT_TIME").toString().substring(0,4));
				}
				if (nowYears - giveYear >= 3) {//判断是否可以报名 1：已到期，0：未到期
					ds.getRecord(i).set("GIVE", "1");
				}else {
					ds.getRecord(i).set("GIVE", "0");
				}
			}else {
				ds.getRecord(i).set("GIVE", "1");
			}
//			dataSet.add(record);
		}
		return ds;
	}
}
