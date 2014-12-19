package com.inspur.cams.marry.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.base.dao.IMrmQualificationExamDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmQualificationExam;
import com.inspur.cams.marry.base.domain.IMrmBasePersonDomain;
import com.inspur.cams.marry.base.domain.IMrmQualificationExamDomain;

public class MrmQualificationExamDomain implements IMrmQualificationExamDomain {
	@Reference	
	private IMrmQualificationExamDao MrmQualificationExamDao;
	IMrmBasePersonDomain mrmBasePersonDomain = ScaComponentFactory.getService(
			IMrmBasePersonDomain.class,
			"MrmBasePersonDomain/MrmBasePersonDomain");
	@Trans
	public void deleteMrmQualificationExam(String ksxxId) {
		// TODO Auto-generated method stub
		MrmQualificationExamDao.delete(ksxxId);
	}
	public DataSet queryMrmQualificationExam(ParameterSet set) {
		// TODO Auto-generated method stub
		return MrmQualificationExamDao.query(set);
	}
	@Trans
	public void updateMrmQualificationExam(MrmQualificationExam mQualificationExam) {
		// TODO Auto-generated method stub
		MrmQualificationExamDao.update(mQualificationExam);
	}
	@Trans
	public void updateMrmQualification(MrmQualificationExam mQualificationExam,MrmBasePerson mrmBasePerson) {
		MrmQualificationExamDao.update(mQualificationExam);
		mrmBasePersonDomain.updateBzyzh(mrmBasePerson);
		mrmBasePersonDomain.updateCertificate(mrmBasePerson);
	}
	@Trans
	public void insertMrmQualificationExam(MrmQualificationExam mExam) {
		// TODO Auto-generated method stub
		MrmQualificationExamDao.insert(mExam);
	}

	public DataSet queryPersonExam(ParameterSet set) {
		// TODO Auto-generated method stub
		return MrmQualificationExamDao.queryPersonExam(set);
	}
	@Trans
	public void batchInsert(List<MrmQualificationExam> list) {
		// TODO Auto-generated method stub
		MrmQualificationExamDao.batchInsert(list);
	}

	public DataSet queryPersonExamExcel(ParameterSet set) {
		return MrmQualificationExamDao.queryPersonExamExcel(set);
	}
	//批量设置合格
	public void plkshgExam(String ksxxId) {
		//return MrmQualificationExamDao.plkshgExam(ksxxId);
		MrmQualificationExamDao.plkshgExam(ksxxId);
	}

}
