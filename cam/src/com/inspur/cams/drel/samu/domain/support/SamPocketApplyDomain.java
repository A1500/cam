package com.inspur.cams.drel.samu.domain.support;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.ws.description.Parameter;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.samu.dao.ISamGeroApplyDao;
import com.inspur.cams.drel.samu.dao.ISamGeroKeptPersonDao;
import com.inspur.cams.drel.samu.dao.jdbc.SamGeroKeptPersonDao;
import com.inspur.cams.drel.samu.data.SamGeroApply;
import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;
import com.inspur.cams.drel.samu.domain.ISamGeroApplyDomain;
import com.inspur.cams.drel.samu.domain.ISamGeroKeptPersonDomain;
import com.inspur.cams.drel.samu.domain.ISamPocketApplyDomain;
import com.inspur.cams.prs.prsattachment.dao.PrsAttachment;
import com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations;

public class SamPocketApplyDomain implements ISamPocketApplyDomain{

	private ISamPocketApplyDomain samPocketApplyDomain = ScaComponentFactory
	.getService(ISamPocketApplyDomain.class, "samPocketApplyDomain/samPocketApplyDomain");
	@Reference
	private ISamGeroApplyDomain samGeroApplyDomain;
	@Reference
	private ISamGeroKeptPersonDomain samGeroKeptPersonDomain;
	/**
	 * 
	 * @param samGeroApply
	 */	
	public void insertSave(String gerocomiumName, String pocketYm,BigDecimal pocketMoney){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumName);
		pset.setParameter("IS_STATUS", "1");
		DataSet ds= samGeroKeptPersonDomain.query(pset);
		List<SamGeroApply> list=new ArrayList <SamGeroApply>();
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=new SamGeroApply();
				samGeroApply.setApplyId(IdHelp.getUUID32());
				samGeroApply.setGerocomiumId((String)record.get("gerocomiumId"));
				samGeroApply.setPersonId((String)record.get("personId"));
				samGeroApply.setApplyType("2");
				samGeroApply.setPocketMoney(pocketMoney);
				samGeroApply.setPocketStatus("0");
				samGeroApply.setPocketYm(pocketYm);
				list.add(samGeroApply);
			}
			samGeroApplyDomain.batchInsert(list);
		}
	}
	/**
	 * 
	 * @param samGeroApply
	 */	
	public void insertSaveCloth(String gerocomiumName, String clothDate,String clothType,BigDecimal clothNum){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumName);
		pset.setParameter("IS_STATUS", "1");
		DataSet ds= samGeroKeptPersonDomain.query(pset);
		List<SamGeroApply> list=new ArrayList <SamGeroApply>();
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=new SamGeroApply();
				samGeroApply.setApplyId(IdHelp.getUUID32());
				samGeroApply.setGerocomiumId((String)record.get("gerocomiumId"));
				samGeroApply.setPersonId((String)record.get("personId"));
				samGeroApply.setApplyType("3");
				samGeroApply.setClothNum(clothNum);
				samGeroApply.setClothType(clothType);
				samGeroApply.setClothStatus("0");
				samGeroApply.setClothDate(clothDate);
				list.add(samGeroApply);
			}
			samGeroApplyDomain.batchInsert(list);
		}
	}
	// 确认名册时，更新发放状态
	public void confirmPocket(String gerocomiumId,String pocketYm,String pocketStatus){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumId);
		pset.setParameter("POCKET_YM", pocketYm);
		pset.setParameter("POCKET_STATUS", pocketStatus);
		DataSet ds= samGeroApplyDomain.query(pset);
		List<SamGeroApply> list=new ArrayList <SamGeroApply>();
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=(SamGeroApply)record.toBean(SamGeroApply.class);
				samGeroApply.setPocketStatus("1");
				list.add(samGeroApply);
			}
			samGeroApplyDomain.batchUpdate(list);
		}
	}
	// 确认名册时，更新发放状态
	public void confirmCloth(String gerocomiumId, String clothDate,String clothStatus){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumId);
		pset.setParameter("CLOTH_DATE", clothDate);
		pset.setParameter("CLOTH_STATUS", clothStatus);
		DataSet ds= samGeroApplyDomain.query(pset);
		List<SamGeroApply> list=new ArrayList <SamGeroApply>();
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=(SamGeroApply)record.toBean(SamGeroApply.class);
				samGeroApply.setClothStatus("1");
				list.add(samGeroApply);
			}
			samGeroApplyDomain.batchUpdate(list);
		}
	}
	// 删除名册
	public void deletePocket(String gerocomiumId,String pocketYm,String pocketStatus){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumId);
		pset.setParameter("POCKET_YM", pocketYm);
		pset.setParameter("POCKET_STATUS", pocketStatus);
		DataSet ds= samGeroApplyDomain.query(pset);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=(SamGeroApply)record.toBean(SamGeroApply.class);
				samGeroApplyDomain.delete(samGeroApply.getApplyId());
			}
			
		}
	}
	// 删除名册
	public void deleteCloth(String gerocomiumId, String clothDate,String clothStatus){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumId);
		pset.setParameter("CLOTH_DATE", clothDate);
		pset.setParameter("CLOTH_STATUS", clothStatus);
		DataSet ds= samGeroApplyDomain.query(pset);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
			    Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=(SamGeroApply)record.toBean(SamGeroApply.class);
				samGeroApplyDomain.delete(samGeroApply.getApplyId());
			}
			
		}
	}
}
