package com.inspur.cams.drel.samu.domain.support;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.IBaseinfoPeopleArchiveDao;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.jdbc.BaseinfoPeopleArchiveDao;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.samu.dao.ISamGeroApplyDao;
import com.inspur.cams.drel.samu.dao.ISamGeroKeptPersonDao;
import com.inspur.cams.drel.samu.data.SamGeroApply;
import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;
import com.inspur.cams.drel.samu.domain.ISamGeroKeptPersonDomain;

/**
 * 供养对象信息表domain
 * @author 
 * @date 2012-10-24
 */
public class SamGeroKeptPersonDomain implements ISamGeroKeptPersonDomain {

	@Reference
	private ISamGeroKeptPersonDao samGeroKeptPersonDao;
	@Reference
	private ISamGeroApplyDao samGeroApplyDao;
	@Reference
	private ISamFamilyTreatmentDao samFamilyTreatmentDao;
	@Reference
	private IBaseinfoPeopleArchiveDao baseinfoPeopleArchiveDao;
	/**
	 * 查询 供养对象信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samGeroKeptPersonDao.query(pset);
	}
	
	/**
	 * 获取 供养对象信息表
	 * @param pset
	 * @return
	 */
	public SamGeroKeptPerson get(String personId) {
		return samGeroKeptPersonDao.get(personId);
	}

	/**
	 * 增加 供养对象信息表
	 * @param samGeroKeptPerson
	 */
	public void insert(SamGeroKeptPerson samGeroKeptPerson) {
		samGeroKeptPersonDao.insert(samGeroKeptPerson);
	}
	
	/**
	 * 修改 供养对象信息表
	 * @param samGeroKeptPerson
	 */
	public void update(SamGeroKeptPerson samGeroKeptPerson) {
		samGeroKeptPersonDao.update(samGeroKeptPerson);
	}
	
	/**
	 * 删除 供养对象信息表
	 * @param personId
	 */
	public void delete(String personId) {
		samGeroKeptPersonDao.delete(personId);
	}
	
	/**
	 * 保存供养对象信息表，同时插入业务表
	 * @param personId
	 */
	public void insertAll(Record[] recordPerson,Record[] recordApply,Record[] recordPeople) {
		if (recordPerson != null) {
			for (int i = 0; i < recordPerson.length; i++) {
				SamGeroApply samGeroApply = (SamGeroApply) recordApply[i].toBean(SamGeroApply.class);
				samGeroApply.setApplyType("0");//0:入院
				samGeroApply.setApplyId(IdHelp.getUUID32());
				samGeroApplyDao.insert(samGeroApply);
			}
			for(int j=0;j<recordPerson.length;j++){
				SamGeroKeptPerson samGeroKeptPerson = (SamGeroKeptPerson) recordPerson[j].toBean(SamGeroKeptPerson.class);
				samGeroKeptPerson.setIsStatus("1");
				samGeroKeptPerson.setCardType("01");//01:身份证
				samGeroKeptPersonDao.insert(samGeroKeptPerson);
			}
			
			for(int k=0;k<recordPeople.length;k++){
				String treatmentId=(String)recordPeople[k].get("TREATMENT_ID");
				String peopleId=(String)recordPeople[k].get("PEOPLE_ID");
				String applyId=(String)recordPeople[k].get("APPLY_ID");
				ParameterSet pset =new ParameterSet();
				pset.setParameter("TREATMENT_ID",treatmentId );
				DataSet ds=samFamilyTreatmentDao.query(pset);
				if(ds.getCount()>0){
					SamFamilyTreatment samFamilyTreatment=(SamFamilyTreatment)ds.getRecord(0).toBean(SamFamilyTreatment.class);
					String gerocomiumId=(String)recordPeople[k].get("GEROCOMIUM_ID");
					if(gerocomiumId.equals(samFamilyTreatment.getSupportOrg())){
						//samFamilyTreatment.setInHospital("1");//更新五保人员信息中是否在院状态字段
						samFamilyTreatmentDao.update(samFamilyTreatment);
					}else{
						samFamilyTreatment.setSupportOrg(gerocomiumId);//更新家庭待遇表中support_org敬老院ID
						//samFamilyTreatment.setInHospital("1");//更新五保人员信息中是否在院状态字段
						samFamilyTreatmentDao.update(samFamilyTreatment);
					}
				}
				//维护五保人员信息中是否在院状态字段
				ParameterSet pset1 =new ParameterSet();
				pset1.setParameter("PEOPLE_ID",peopleId );
				pset1.setParameter("APPLY_ID",applyId );
				DataSet ds1=baseinfoPeopleArchiveDao.query(pset1);
				if(ds1.getCount()>0){
					BaseinfoPeopleArchive baseinfoPeopleArchive=(BaseinfoPeopleArchive)ds1.getRecord(0).toBean(BaseinfoPeopleArchive.class);
					baseinfoPeopleArchive.setInHospital("1");//更新五保人员信息中是否在院状态字段
					baseinfoPeopleArchiveDao.update(baseinfoPeopleArchive);
				}
			}
		}
	}
	/**
	 * 出院业务，并更新信息表
	 * @param personId
	 */
	public void outGero(Record recordPerson,Record recordApply) {
		SamGeroApply samGeroApply = (SamGeroApply) recordApply.toBean(SamGeroApply.class);
		samGeroApplyDao.insert(samGeroApply);
		SamGeroKeptPerson samGeroKeptPerson = (SamGeroKeptPerson) recordPerson.toBean(SamGeroKeptPerson.class);
		samGeroKeptPerson.setIsStatus("0");
		samGeroKeptPerson.setInoutDate(samGeroApply.getOutDate());
		samGeroKeptPerson.setReason(samGeroApply.getReason());
		samGeroKeptPerson.setUpdatePerson(samGeroApply.getUpdatePerson());
		samGeroKeptPerson.setInRoom(null);
		samGeroKeptPerson.setInBed(null);
		samGeroKeptPersonDao.update(samGeroKeptPerson);
		ParameterSet pset =new ParameterSet();
		pset.setParameter("ID_CARD",samGeroKeptPerson.getIdCard());
		DataSet ds=baseinfoPeopleArchiveDao.query(pset);
		if(ds.getCount()>0){
			BaseinfoPeopleArchive baseinfoPeopleArchive=(BaseinfoPeopleArchive)ds.getRecord(0).toBean(BaseinfoPeopleArchive.class);
			/*ParameterSet set=new ParameterSet();
			set.setParameter("APPLY_ID",baseinfoPeopleArchive.getApplyId());
			set.setParameter("SUPPORT_WAY", "03");
			set.setParameter("IN_HOSPITAL", "1");
			DataSet dsTreatment=samFamilyTreatmentDao.query(set);
			if(dsTreatment.getCount()>0){
				SamFamilyTreatment samFamilyTreatment=(SamFamilyTreatment)dsTreatment.getRecord(0).toBean(SamFamilyTreatment.class);
				samFamilyTreatment.setInHospital(null);//更新五保人员信息中是否在院状态字段
				samFamilyTreatmentDao.update(samFamilyTreatment);
			}*/
			baseinfoPeopleArchive.setInHospital(null);//更新五保人员信息中是否在院状态字段
			baseinfoPeopleArchiveDao.update(baseinfoPeopleArchive);
		}
	}
	/**
	 * 维护查体名册时，增加时查询不在查体名册的人员
	 * @param pset
	 * @return
	 */
	public DataSet queryInsertPerson(ParameterSet pset){
		return samGeroKeptPersonDao.queryInsertPerson(pset);
	}
	//查询入出院供养对象列表
	public DataSet queryInoutList(ParameterSet pset){
		return samGeroKeptPersonDao.queryInoutList(pset);
	}
	//统计五保供养对象信息表
	public DataSet reportSupportInfo(ParameterSet pset){
		return samGeroKeptPersonDao.reportSupportInfo(pset);
	}
	//入出院记录信息查询表
	public DataSet queryInoutRecord(ParameterSet pset){
		return samGeroKeptPersonDao.queryInoutRecord(pset);
	}
}