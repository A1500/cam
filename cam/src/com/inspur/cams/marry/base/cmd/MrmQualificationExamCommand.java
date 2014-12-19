package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.MrmExamApply;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmExamSchedule;
import com.inspur.cams.marry.base.data.MrmQualificationExam;
import com.inspur.cams.marry.base.domain.IMrmQualificationExamDomain;


/**
 * @title:MrmQualificationExamCommand
 * @description:
 * @author:
 * @since:2011-12-01
 * @version:1.0
 */
public class MrmQualificationExamCommand extends BaseAjaxCommand {

	IMrmQualificationExamDomain iMrmQualificationExamDomain = ScaComponentFactory
			.getService(IMrmQualificationExamDomain.class,
					"MrmQualificationExamDomain/MrmQualificationExamDomain");
	//增加
	public void insert() {
		Record record = (Record) getParameter("records");
		MrmQualificationExam dataBean = (MrmQualificationExam) record
				.toBean(MrmQualificationExam.class);
		String ksxxId = IdHelp.getUUID32();
		dataBean.setKsxxId(ksxxId);
		iMrmQualificationExamDomain.insertMrmQualificationExam(dataBean);
	}
	//修改
	public void update() {
		Record[] record = (Record[]) getParameter("records");
		List<MrmQualificationExam> mrmQExamList = new ArrayList<MrmQualificationExam>();
		
		for (int i = 0; i < record.length; i++) {
			MrmQualificationExam mExamBean = new MrmQualificationExam();
			MrmBasePerson mrmBasePerson = new MrmBasePerson();
			if (record[i].get("KSXX_ID") != null && !"".equals(record[i].get("KSXX_ID"))) {
				mExamBean.setKsxxId(record[i].get("KSXX_ID").toString());
			}
			mExamBean.setAutomaticFailureTime(record[i].get("AUTOMATIC_FAILURE_TIME").toString());
			mExamBean.setBackoutTime(record[i].get("BACKOUT_TIME").toString());
			mExamBean.setBkjg(record[i].get("BKJG").toString());
			if (record[i].get("CERTIFICATE_ID") != null && !"".equals(record[i].get("CERTIFICATE_ID"))) {
				mExamBean.setCertificateId(record[i].get("CERTIFICATE_ID").toString());
				mrmBasePerson.setCertificateId(record[i].get("CERTIFICATE_ID").toString());
			}
			if (record[i].get("BZYZGZH") != null && !"".equals(record[i].get("BZYZGZH"))) {
				mExamBean.setCertificateId(record[i].get("BZYZGZH").toString());
				mrmBasePerson.setBzyzgzh(record[i].get("BZYZGZH").toString());
			}
			mExamBean.setCkfkbz(record[i].get("CKFKBZ").toString());
			mExamBean.setFillCardTime(record[i].get("FILL_CARD_TIME").toString());
			mExamBean.setGiveOutTime(record[i].get("GIVE_OUT_TIME").toString());
			if (record[i].get("KSAP_ID") != null && !"".equals(record[i].get("KSAP_ID"))) {
				mExamBean.setKsapId(record[i].get("KSAP_ID").toString());
			}
			mExamBean.setKsjg(record[i].get("KSJG").toString());
			mExamBean.setKsqs(record[i].get("KSQS").toString());
			mExamBean.setKssjTime(record[i].get("KSSJ_TIME").toString());
			mExamBean.setNdYear(record[i].get("ND_YEAR").toString());
			if (record[i].get("ORGAN_ID") != null && !"".equals(record[i].get("ORGAN_ID"))) {
				mExamBean.setOrganId(record[i].get("ORGAN_ID").toString());
			}
			if (record[i].get("PERSON_ID") != null && !"".equals(record[i].get("PERSON_ID"))) {
				mExamBean.setPersonId(record[i].get("PERSON_ID").toString());
				mrmBasePerson.setPersonId(record[i].get("PERSON_ID").toString());
			}
			if (record[i].get("ZGZZT") != null && !"".equals(record[i].get("ZGZZT"))) {
				mExamBean.setZgzzt(record[i].get("ZGZZT").toString());
			}
			if (record[i].get("CXYY") != null && !"".equals(record[i].get("CXYY"))) {
				mExamBean.setCxyy(record[i].get("CXYY").toString());
			}
			
			iMrmQualificationExamDomain.updateMrmQualification(mExamBean,mrmBasePerson);
		}
	}
	
	public void updateQualification() {
		Record record = (Record) getParameter("record");
		MrmQualificationExam mrmQualificationExam=(MrmQualificationExam)record.toBean(MrmQualificationExam.class);
		if (record.get("KSXX_ID") != null && !"".equals(record.get("KSXX_ID"))) {
			mrmQualificationExam.setKsxxId(record.get("KSXX_ID").toString());
		}
		mrmQualificationExam.setAutomaticFailureTime(record.get("AUTOMATIC_FAILURE_TIME").toString());
		mrmQualificationExam.setBackoutTime(record.get("BACKOUT_TIME").toString());
		mrmQualificationExam.setBkjg(record.get("BKJG").toString());
		mrmQualificationExam.setCertificateId(record.get("CERTIFICATE_ID").toString());
		mrmQualificationExam.setCkfkbz(record.get("CKFKBZ").toString());
		mrmQualificationExam.setFillCardTime(record.get("FILL_CARD_TIME").toString());
		mrmQualificationExam.setGiveOutTime(record.get("GIVE_OUT_TIME").toString());
		if (record.get("KSAP_ID") != null && !"".equals(record.get("KSAP_ID"))) {
			mrmQualificationExam.setKsapId(record.get("KSAP_ID").toString());
		}
//		mrmQualificationExam.setKsjg(record.get("KSJG").toString());
		mrmQualificationExam.setKsqs(record.get("KSQS").toString());
		mrmQualificationExam.setKssjTime(record.get("KSSJ_TIME").toString());
		mrmQualificationExam.setNdYear(record.get("ND_YEAR").toString());
		if (record.get("ORGAN_ID") != null && !"".equals(record.get("ORGAN_ID"))) {
			mrmQualificationExam.setOrganId(record.get("ORGAN_ID").toString());
		}
		if (record.get("PERSON_ID") != null && !"".equals(record.get("PERSON_ID"))) {
			mrmQualificationExam.setPersonId(record.get("PERSON_ID").toString());
		}
		if (record.get("ZGZZT") != null && !"".equals(record.get("ZGZZT"))) {
			mrmQualificationExam.setZgzzt(record.get("ZGZZT").toString());
		}
		if (record.get("CXYY") != null && !"".equals(record.get("CXYY"))) {
			mrmQualificationExam.setCxyy(record.get("CXYY").toString());
		}
		iMrmQualificationExamDomain.updateMrmQualificationExam(mrmQualificationExam);
	}
	//删除
	public void delete() {
		String ksxxId  = (String) getParameter("delIds");
		String[] ks = ksxxId.split(",");
		for (int i = 0; i < ks.length; i++) {
			String kssxx = ks[i];
			iMrmQualificationExamDomain.deleteMrmQualificationExam(kssxx);
		}
	}
	public void baoming(){

		Record record = (Record) getParameter("record");
		MrmExamSchedule apBean=(MrmExamSchedule)record.toBean(MrmExamSchedule.class);
		
		Record[] records = (Record[]) getParameter("records");
		List<MrmQualificationExam> list = new ArrayList<MrmQualificationExam>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmBasePerson ryBean = (MrmBasePerson) records[i].toBean(MrmBasePerson.class);
			MrmQualificationExam dataBean=new MrmQualificationExam();
			dataBean.setKsxxId(IdHelp.getUUID32());
			//人员id
			dataBean.setPersonId(ryBean.getPersonId());
			//考试安排信息
			dataBean.setNdYear(apBean.getNdYear());
			dataBean.setKsqs(apBean.getKsqs());
			dataBean.setKssjTime(apBean.getKsbeginTime());
	//		iMrmQualificationExamDomain.insertMrmQualificationExam(dataBean);
			list.add(dataBean);
			
		}
		iMrmQualificationExamDomain.batchInsert(list);
	}
	//批量设置考试合格
	public void plkshg(){
		String ksxxId  = (String) getParameter("delIds");
		//String delIds = (String) getParameter("delIds");
//		String[] ks = ksxxId.split(",");
//		for (int i = 0; i < ks.length; i++) {
//			String kssxx = ks[i];
//			List<MrmQualificationExam> mrmQExamList = new ArrayList<MrmQualificationExam>();
//			iMrmQualificationExamDomain.plkshgExam(ksxxId);
//		}
		iMrmQualificationExamDomain.plkshgExam(ksxxId);
}
}
