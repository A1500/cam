package com.inspur.cams.drel.samu.domain.support;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.samu.dao.ISamGeroApplyDao;
import com.inspur.cams.drel.samu.data.SamGeroApply;
import com.inspur.cams.drel.samu.data.SamRoomInfo;
import com.inspur.cams.drel.samu.domain.ISamGeroApplyDomain;

/**
 * 敬老院业务主表domain
 * @author 
 * @date 2012-10-24
 */
public class SamGeroApplyDomain implements ISamGeroApplyDomain {

	@Reference
	private ISamGeroApplyDao samGeroApplyDao;

	/**
	 * 查询 敬老院业务主表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samGeroApplyDao.query(pset);
	}

	/**
	 * 获取 敬老院业务主表
	 * @param pset
	 * @return
	 */
	public SamGeroApply get(String applyId) {
		return samGeroApplyDao.get(applyId);
	}

	/**
	 * 增加 敬老院业务主表
	 * @param samGeroApply
	 */
	public void insert(SamGeroApply samGeroApply) {
		samGeroApplyDao.insert(samGeroApply);
	}
	
	/**
	 * 修改 敬老院业务主表
	 * @param samGeroApply
	 */
	public void update(SamGeroApply samGeroApply) {
		samGeroApplyDao.update(samGeroApply);
	}
	/**@tr
	 * 批量增加 敬老院业务主表
	 * @param samGeroApply
	 */
	public void batchInsert(List<SamGeroApply> args) {
		samGeroApplyDao.batchInsert(args);
	}
	/**@tr
	 * 批量更新零花钱发放状态 确认名册
	 * @param samGeroApply
	 */
	public void batchUpdate(List<SamGeroApply> args) {
		samGeroApplyDao.batchUpdate(args);
	}
	
	/**@tr
	 * 查询 敬老院零花钱列表
	 * @param pset
	 * @return
	 */
	public DataSet queryMoneryList(ParameterSet pset) {
		return samGeroApplyDao.queryMoneryList(pset);
	}
	/**@tr
	 * 敬老院零花钱统计
	 * @param pset
	 * @return
	 */
	public DataSet queryPocketList(ParameterSet pset) {
		return samGeroApplyDao.queryPocketList(pset);
	}
	/**@tr
	 * 敬老院服装统计
	 * @param pset
	 * @return
	 */
	public DataSet applyClothList(ParameterSet pset) {
		return samGeroApplyDao.applyClothList(pset);
	}
	/**@tr
	 * 敬老院查体统计
	 * @param pset
	 * @return
	 */
	public DataSet applyCheckList(ParameterSet pset) {
		return samGeroApplyDao.applyCheckList(pset);
	}
	/**@tr
	 * 查询 敬老院服装列表
	 * @param pset
	 * @return
	 */
	public DataSet queryClothList(ParameterSet pset) {
		return samGeroApplyDao.queryClothList(pset);
	}
	/**@tr
	 * 查询 敬老院零花钱明细列表
	 * @param pset
	 * @return
	 */
	public DataSet queryMoneyDetail(ParameterSet pset) {
		return samGeroApplyDao.queryMoneyDetail(pset);
	}
	/**@tr
	 * 查询 敬老院服装明细列表
	 * @param pset
	 * @return
	 */
	public DataSet queryClothDetail(ParameterSet pset) {
		return samGeroApplyDao.queryClothDetail(pset);
	}
	/**
	 * 删除 敬老院业务主表
	 * @param applyId
	 */
	public void delete(String applyId) {
		samGeroApplyDao.delete(applyId);
	}
	/**
	 * 查询 查体名册
	 * @param pset
	 * @return
	 */
	public DataSet queryList(ParameterSet pset){
		return samGeroApplyDao.queryList(pset);
	}
	/**
	 * 增加查体信息
	 * @param pset
	 * @return
	 */
	public void insertCheck(String gerocomiumName,String checkDate,String checkResult){
		samGeroApplyDao.insertCheck(gerocomiumName,checkDate,checkResult);
	}
	/**
	 * 维护名册时，弹出查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryCheckDetail(ParameterSet pset){
		return samGeroApplyDao.queryCheckDetail(pset);
	}
	/**
	 * 维护名册时，更新查体信息
	 * @param pset
	 * @return
	 */
	public void saveCheck(Record[] records){
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				//SamGeroApply bean=(SamGeroApply)records[i].toBean(SamGeroApply.class);
				if (records[i].getState() == Record.STATE_MODIFIED) {
					ParameterSet pset =new ParameterSet();
					pset.setParameter("GEROCOMIUM_ID", records[i].get("GEROCOMIUM_ID"));
					pset.setParameter("CHECK_DATE", records[i].get("CHECK_DATE"));
					pset.setParameter("PERSON_ID", records[i].get("PERSON_ID"));
					DataSet ds=samGeroApplyDao.query(pset);
					if(ds.getCount() > 0){
						SamGeroApply bean=(SamGeroApply)ds.getRecord(0).toBean(SamGeroApply.class);
						bean.setCheckResult((String)records[i].get("CHECK_RESULT"));
						samGeroApplyDao.update(bean);
					}
					
				} else if (records[i].getState() == Record.STATE_DELETED) {
					samGeroApplyDao.delete((String)records[i].get("APPLY_ID"));
				}else if(records[i].getState() == Record.STATE_NEW){
					Record record=new Record();
					record.set("applyId", IdHelp.getUUID32());
					record.set("personId",records[i].get("PERSON_ID"));
					record.set("gerocomiumId",records[i].get("GEROCOMIUM_ID"));
					record.set("applyType","4");
					record.set("checkDate",records[i].get("CHECK_DATE"));
					record.set("checkResult",records[i].get("CHECK_RESULT"));
					record.set("remarks", records[i].get("REMARKS"));
					SamGeroApply bean=(SamGeroApply)record.toBean(SamGeroApply.class);
					samGeroApplyDao.insert(bean);
				}
			}
		}
	}
	/**@tr
	 * 维护名册时，更新发放信息
	 * @param pset
	 * @return
	 */
	public void saveCheckM(Record[] records){		
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				//SamGeroApply bean=(SamGeroApply)records[i].toBean(SamGeroApply.class);
				if (records[i].getState() == Record.STATE_MODIFIED) {
					ParameterSet pset =new ParameterSet();
					pset.setParameter("GEROCOMIUM_ID", records[i].get("GEROCOMIUM_ID"));
					pset.setParameter("POCKET_YM", records[i].get("POCKET_YM"));
					pset.setParameter("PERSON_ID", records[i].get("PERSON_ID"));
					DataSet ds=samGeroApplyDao.query(pset);
					BigDecimal pocketMoney= new BigDecimal(records[i].get("POCKET_MONEY").toString());
					if(ds.getCount() > 0){
						SamGeroApply bean=(SamGeroApply)ds.getRecord(0).toBean(SamGeroApply.class);
						bean.setPocketMoney(pocketMoney);
						
						samGeroApplyDao.update(bean);
					}
					
				} else if (records[i].getState() == Record.STATE_DELETED) {
					samGeroApplyDao.delete((String)records[i].get("APPLY_ID"));
				}else if(records[i].getState() == Record.STATE_NEW){
					Record record=new Record();
					record.set("applyId", IdHelp.getUUID32());
					record.set("personId",records[i].get("PERSON_ID"));
					record.set("gerocomiumId",records[i].get("GEROCOMIUM_ID"));
					record.set("applyType","2");
					record.set("pocketYm",records[i].get("POCKET_YM"));
					record.set("pocketMoney",records[i].get("POCKET_MONEY"));
					record.set("pocketStatus","0");
					SamGeroApply bean=(SamGeroApply)record.toBean(SamGeroApply.class);
					samGeroApplyDao.insert(bean);
				}
			}
		}
	}
	/**@tr
	 * 维护名册时，更新发放信息
	 * @param pset
	 * @return
	 */
	public void saveCheckCloth(Record[] records){		
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				//SamGeroApply bean=(SamGeroApply)records[i].toBean(SamGeroApply.class);
				if (records[i].getState() == Record.STATE_MODIFIED) {
					ParameterSet pset =new ParameterSet();
					pset.setParameter("GEROCOMIUM_ID", records[i].get("GEROCOMIUM_ID"));
					pset.setParameter("CLOTH_DATE", records[i].get("CLOTH_DATE"));
					pset.setParameter("PERSON_ID", records[i].get("PERSON_ID"));
					DataSet ds=samGeroApplyDao.query(pset);
					BigDecimal clothNum= new BigDecimal(records[i].get("CLOTH_NUM").toString());
					if(ds.getCount() > 0){
						SamGeroApply bean=(SamGeroApply)ds.getRecord(0).toBean(SamGeroApply.class);
						bean.setClothNum(clothNum);
					
						samGeroApplyDao.update(bean);
					}
					
				} else if (records[i].getState() == Record.STATE_DELETED) {
					samGeroApplyDao.delete((String)records[i].get("APPLY_ID"));
				}else if(records[i].getState() == Record.STATE_NEW){
					Record record=new Record();
					record.set("applyId", IdHelp.getUUID32());
					record.set("personId",records[i].get("PERSON_ID"));
					record.set("gerocomiumId",records[i].get("GEROCOMIUM_ID"));
					record.set("applyType","3");
					record.set("clothType",records[i].get("CLOTH_TYPE"));
					record.set("clothDate",records[i].get("CLOTH_DATE"));
					record.set("clothNum",records[i].get("CLOTH_NUM"));
					record.set("clothStatus","0");
					SamGeroApply bean=(SamGeroApply)record.toBean(SamGeroApply.class);
					samGeroApplyDao.insert(bean);
				}
			}
		}
	}
	/**
	 * 删除查体名册时
	 * @param pset
	 * @return
	 */
	@Trans
	public void deleteCheckList(String gerocomiumId,String checkDate){
		ParameterSet pset=new ParameterSet();
		pset.setParameter("GEROCOMIUM_ID", gerocomiumId);
		pset.setParameter("CHECK_DATE", checkDate);
		DataSet ds=samGeroApplyDao.query(pset);
		if(ds.getCount() > 0){
			for(int i=0;i<ds.getCount();i++){
				SamGeroApply bean=(SamGeroApply)ds.getRecord(i).toBean(SamGeroApply.class);
				samGeroApplyDao.delete(bean.getApplyId());
			}
		}
	}
}