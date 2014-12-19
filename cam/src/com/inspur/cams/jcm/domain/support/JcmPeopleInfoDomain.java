package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPeopleCompanyDao;
import com.inspur.cams.jcm.dao.IJcmPeopleExamDao;
import com.inspur.cams.jcm.dao.IJcmPeopleInfoDao;
import com.inspur.cams.jcm.dao.IJcmPeopleResumeDao;
import com.inspur.cams.jcm.data.JcmPeopleInfo;
import com.inspur.cams.jcm.domain.IJcmPeopleInfoDomain;

/**
 * 人员基本信息domain
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleInfoDomain implements IJcmPeopleInfoDomain {

	@Reference
	private IJcmPeopleInfoDao jcmPeopleInfoDao;
	
	@Reference
	private IJcmPeopleResumeDao jcmPeopleResumeDao;
	
	@Reference
	private IJcmPeopleCompanyDao jcmPeopleCompanyDao;
	
	@Reference
	private IJcmPeopleExamDao jcmPeopleExamDao;

	/**
	 * 查询 人员基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPeopleInfoDao.query(pset);
	}

	/**
	 * 获取 人员基本信息
	 * @param pset
	 * @return
	 */
	public JcmPeopleInfo get(String peopleId) {
		return jcmPeopleInfoDao.get(peopleId);
	}

	/**
	 * 增加 人员基本信息
	 * @param jcmPeopleInfo
	 */
	public void insert(JcmPeopleInfo jcmPeopleInfo) {
		jcmPeopleInfoDao.insert(jcmPeopleInfo);
	}
	
	/**
	 * 修改 人员基本信息
	 * @param jcmPeopleInfo
	 */
	public void update(JcmPeopleInfo jcmPeopleInfo) {
		jcmPeopleInfoDao.update(jcmPeopleInfo);
	}
	
	/**
	 * 删除 人员基本信息
	 * @param peopleId
	 */
	public void delete(String peopleId) {
		jcmPeopleInfoDao.delete(peopleId);
	}
	
	/**
	 * 保存人员相关信息
	 * @param peopleId
	 */
	public void save(JcmPeopleInfo jcmPeopleInfo,List resumeList,List companyList,List examList) {
		//保存人员基本信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", jcmPeopleInfo.getPeopleId());
		DataSet infoDs = jcmPeopleInfoDao.query(pset);
		if(infoDs.getCount()<1){
			jcmPeopleInfoDao.insert(jcmPeopleInfo);
		}else{
			jcmPeopleInfoDao.update(jcmPeopleInfo);
		}
		//保存人员简历信息
		jcmPeopleResumeDao.save(resumeList);
		//保存人员工作单位信息
		jcmPeopleCompanyDao.save(companyList);
		//保存人员培训信息
		jcmPeopleExamDao.save(examList);
	}
	
	/**
	 * 删除人员相关信息
	 * @param peopleId
	 */
	@Trans
	public void deleteAll(String peopleId){
		//删除人员基本信息
		jcmPeopleInfoDao.delete(peopleId);
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		//删除人员简历信息
		DataSet resumeDs = jcmPeopleResumeDao.query(pset);
		for(int i = 0;i<resumeDs.getCount();i++){
			jcmPeopleResumeDao.delete(resumeDs.getRecord(i).get("resumeId"));
		}
		//删除人员单位信息
		DataSet companyDs = jcmPeopleCompanyDao.query(pset);
		for(int i = 0;i<companyDs.getCount();i++){
			jcmPeopleCompanyDao.delete(companyDs.getRecord(i).get("peopleCompanyId"));
		}
		//删除人员培训信息
		DataSet examDs = jcmPeopleExamDao.query(pset);
		for(int i = 0;i<examDs.getCount();i++){
			jcmPeopleExamDao.delete(examDs.getRecord(i).get("peopleExamId"));
		}
	}

}