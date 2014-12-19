package com.inspur.cams.marry.base.cmd;

import java.util.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmExamScheduleDao;
import com.inspur.cams.marry.base.data.MrmExamSchedule;
import com.inspur.cams.marry.base.data.MrmQualificationExam;
import com.inspur.cams.marry.base.domain.IMrmQualificationExamDomain;


/**
 * @title:MrmExamScheduleCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class MrmExamScheduleCommand extends BaseAjaxCommand{
	private MrmExamScheduleDao dao = (MrmExamScheduleDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmExamScheduleDao");

	IMrmQualificationExamDomain iMrmQualificationExamDomain = ScaComponentFactory
	.getService(IMrmQualificationExamDomain.class,
			"MrmQualificationExamDomain/MrmQualificationExamDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmExamSchedule dataBean=(MrmExamSchedule)record.toBean(MrmExamSchedule.class);
		String ksapId = IdHelp.getUUID32();
		dataBean.setKsapId(ksapId);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		MrmExamSchedule dataBean=(MrmExamSchedule)record.toBean(MrmExamSchedule.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmExamSchedule> list = new ArrayList<MrmExamSchedule>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmExamSchedule dataBean = (MrmExamSchedule) records[i].toBean(MrmExamSchedule.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	
	/**
	 * 考试报名
	 */
	public void mrmexamapply(){
		String[] personId = (String[]) getParameter("personId");
		String[] ksqs = (String[]) getParameter("ksqs");
		String[] organId = (String[]) getParameter("organId");
		String[] name = (String[]) getParameter("name");
		String ndYear = (String) getParameter("ndYear");
		String ksSign = (String) getParameter("ksSign");
		String nameadd = "";//是否已报名
		String bmadd = "";//是否超过报名人数
		String qstj = "";//期数统计
		//判断是否已报名
		for (int i = 0; i < personId.length; i++) {
			ParameterSet qualificationPset = new ParameterSet();
			qualificationPset.setParameter("MRM_QUALIFICATION_EXAM.PERSON_ID", personId[i].toString());
			qualificationPset.setParameter("MRM_QUALIFICATION_EXAM.ND_YEAR", ndYear);
			DataSet personIDataSet = iMrmQualificationExamDomain.queryMrmQualificationExam(qualificationPset);
			/*if (personIDataSet.getRecord(0).get("ksapId") != null && !"".equals(personIDataSet.getRecord(0).get("ksapId"))) {
				String qExamKapId = personIDataSet.getRecord(0).get("ksapId").toString();
				ParameterSet pSet = new ParameterSet();
				pSet.setParameter("MRM_EXAM_SCHEDULE.KSQS@=", ksqs[i]);
				pSet.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=", ndYear);
				pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				DataSet ksapDataSet = dao.query(pSet);
				String ksapId = ksapDataSet.getRecord(0).get("ksapId").toString();
				if (!"".equals(personIDataSet.getCount()) && personIDataSet.getCount() != 0) {
					if (qExamKapId.equals(ksapId)) {
						nameadd += name[i].toString()+" ";
					}
				}
			}else {*/
					if (!"".equals(personIDataSet.getCount()) && personIDataSet.getCount() != 0) {
						//if (personIDataSet.getRecord(0).get("ksapId") != null && !"".equals(personIDataSet.getRecord(0).get("ksapId"))) {
							String qExamKapId = personIDataSet.getRecord(0).get("ksapId").toString();
							ParameterSet pSet = new ParameterSet();
							pSet.setParameter("MRM_EXAM_SCHEDULE.KSQS@=", ksqs[i]);
							pSet.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=", ndYear);
							pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
							DataSet ksapDataSet = dao.query(pSet);
							String ksapId = ksapDataSet.getRecord(0).get("ksapId").toString();
							//if (!"".equals(personIDataSet.getCount()) && personIDataSet.getCount() != 0) {
								if (qExamKapId.equals(ksapId)) {
									nameadd += name[i].toString()+" ";
							//	}
							}
//						}else{
//							nameadd += name[i].toString()+" ";
//						}
					}
			//	}
		}
		this.setReturn("name", nameadd);
		//判断考试是否开启
		if ("".equals(nameadd)) {
			for (int i = 0; i < personId.length; i++) {
				ParameterSet pSet = new ParameterSet();
				pSet.setParameter("MRM_EXAM_SCHEDULE.KSQS@=", ksqs[i]);
				pSet.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=", ndYear);
				if ("0".equals(ksSign)) {
					pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				}else if ("1".equals(ksSign)) {
					pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				}
				DataSet ksapDataSet = dao.query(pSet);
				String ksYn = "";//是否开启关闭
				String ksqString = "";//考试期数
				if (ksapDataSet.getRecord(0).get("ksYn") != null && !"".equals(ksapDataSet.getRecord(0).get("ksYn"))) {
					ksYn = ksapDataSet.getRecord(0).get("ksYn").toString();
				}
				if (ksYn != null && !"".equals(ksYn) && ksYn.equals("02")) {
					if (ksapDataSet.getRecord(0).get("ksqs") != null && !"".equals(ksapDataSet.getRecord(0).get("ksqs"))) {
						ksqString = ksapDataSet.getRecord(0).get("ksqs").toString();
					}
					qstj += " "+ksqString+"期 ";
				}
				if (ksYn == null || "".equals(ksYn)) {
					if (ksapDataSet.getRecord(0).get("ksqs") != null && !"".equals(ksapDataSet.getRecord(0).get("ksqs"))) {
						ksqString = ksapDataSet.getRecord(0).get("ksqs").toString();
					}
					qstj += " "+ksqString+"期 ";
				}
			}
			this.setReturn("qstj", qstj);
		}
		//判断是否超过报名人数
		if ("".equals(qstj) && "".equals(bmadd)) {
			for (int i = 0; i < personId.length; i++) {
				ParameterSet pSet = new ParameterSet();
				pSet.setParameter("MRM_EXAM_SCHEDULE.KSQS@=", ksqs[i]);
				pSet.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=", ndYear);
				if ("0".equals(ksSign)) {
					pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				}else if ("1".equals(ksSign)) {
					pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				}
				DataSet ksapDataSet = dao.query(pSet);
				int ksPeonum = 0;//计划安排人数
				String ksapId = "";
				if (ksapDataSet.getRecord(0).get("ksPeonum") != null && !"".equals(ksapDataSet.getRecord(0).get("ksPeonum"))) {
					ksPeonum = Integer.parseInt(ksapDataSet.getRecord(0).get("ksPeonum").toString());
				}
				ParameterSet numpSet = new ParameterSet();
			/*	numpSet.setParameter("ksqs", ksqs[i]);
				numpSet.setParameter("nd_year", ndYear);
				numpSet.setParameter("ksSign", ksSign);*/
				
				if (ksapDataSet.getRecord(0).get("ksapId") != null && !"".equals(ksapDataSet.getRecord(0).get("ksapId"))) {
					ksapId = ksapDataSet.getRecord(0).get("ksapId").toString();
				}
				numpSet.setParameter("ksapId", ksapId);
				DataSet numExamDataSet = dao.sumExamSchedule(numpSet);
				int numExam = 0;
				if (numExamDataSet.getRecord(0).get("KSRS") != null && !"".equals(numExamDataSet.getRecord(0).get("KSRS"))) {
					numExam = Integer.parseInt(numExamDataSet.getRecord(0).get("KSRS").toString());
				}
				
				if (ksPeonum < (numExam + i + 1)) {
					bmadd = " "+ksPeonum+"人，已报名"+numExam+"人！ ";
					if (ksPeonum > numExam) {
						bmadd += "您只能报"+(ksPeonum-numExam)+"人"; 
					}
					if (ksPeonum <= numExam) {
						bmadd += "报名人数已满"; 
					}
				}
			}
			this.setReturn("bmadd", bmadd);
		}
		
		if ("".equals(nameadd) && "".equals(bmadd) && "".equals(qstj)) {
			for (int i = 0; i < personId.length; i++) {
				MrmQualificationExam mExamBean = new MrmQualificationExam();
	
				mExamBean.setPersonId(personId[i].toString());
				mExamBean.setOrganId(organId[i].toString());
				mExamBean.setKsxxId(IdHelp.getUUID32());
		//		mExamBean.setKsapId(ksapId[i].toString());
				
				ParameterSet pSet = new ParameterSet();
				pSet.setParameter("MRM_EXAM_SCHEDULE.KSQS@=", ksqs[i]);
				pSet.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=", ndYear);
				pSet.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=", ksSign);
				DataSet ksapDataSet = dao.query(pSet);
//				String ndYear = ksapDataSet.getRecord(0).get("ndYear").toString();
				String ksbeginTime = ksapDataSet.getRecord(0).get("ksbeginTime").toString();
				//String ksqs = ksapDataSet.getRecord(0).get("ksqs").toString();
				String ksapId = ksapDataSet.getRecord(0).get("ksapId").toString();
				mExamBean.setNdYear(ndYear);
				mExamBean.setKsqs(ksqs[i]);
				mExamBean.setKssjTime(ksbeginTime);
				//mExamBean.setKsqs(ksqs);
				mExamBean.setKsapId(ksapId);
//				mExamBean.setKsjg("01");//01:合格，02：补考
				
				iMrmQualificationExamDomain.insertMrmQualificationExam(mExamBean);
			}
		}
	}
}
