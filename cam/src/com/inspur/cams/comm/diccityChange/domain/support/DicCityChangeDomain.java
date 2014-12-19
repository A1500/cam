package com.inspur.cams.comm.diccityChange.domain.support;

import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeDao;
import com.inspur.cams.comm.diccityChange.dao.IDicCityDataTransDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChange;
import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.DicUtil;

/**
 * 行政区划变更domain
 * 
 * @author
 * @date 2013-12-23
 */
public class DicCityChangeDomain implements IDicCityChangeDomain {

	@Reference
	private IDicCityChangeDao dicCityChangeDao;
	@Reference
	private IDicCityDataTransDao dicCityDataTransDao;
	/**
	 * 查询 行政区划变更
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCityChangeDao.query(pset);
	}

	public String getNumber(String batchId){
		return dicCityChangeDao.getNumber(batchId);
	}
	/**
	 * 获取 行政区划变更
	 * 
	 * @param pset
	 * @return
	 */
	public DicCityChange get(String changeId) {
		return dicCityChangeDao.get(changeId);
	}

	/**
	 * 增加 行政区划变更
	 * 
	 * @param dicCityChange
	 */
	public void insert(DicCityChange dicCityChange) {
		String changeType = dicCityChange.getChangeType();
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setChangeResult("0");
		dicCityChange.setPreUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreUpsCode(), "NAME"));
		dicCityChange.setLeve(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreChangeCode(), "LEVE"));
		if ("01".equals(changeType)) {
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','','','"
					+ dicCityChange.getPreUpsCode() + "','01','"+ batchId+ "','"+ changeId+ "');");
		}else if("02".equals(changeType.substring(0, 2))){
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','"
					+ dicCityChange.getPostChangeCode() + "','"
					+ dicCityChange.getPostChangeName() + "','"
					+ dicCityChange.getPostUpsCode() + "','02','"+ batchId+ "','"+ changeId+ "');");
			dicCityChange.setPostUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPostUpsCode(), "NAME"));
		}
		dicCityChangeDao.insert(dicCityChange);
	}

	/**
	 * 增加 行政区划删除
	 * 
	 * @param dicCityChange
	 */
	public void insertD(DicCityChange dicCityChange) {
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setPreUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreUpsCode(), "NAME"));
		dicCityChange.setLeve(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreChangeCode(), "LEVE"));
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','','','"
					+ dicCityChange.getPreUpsCode() + "','03','"+ batchId+ "','"+ changeId+ "');");
		dicCityChangeDao.insert(dicCityChange);
		dicCityDataTransDao.batchInsert(dicCityChange.getDicCityDataTransList());
	}
	/**
	 * 修改 行政区划变更
	 * 
	 * @param dicCityChange
	 */
	public void update(DicCityChange dicCityChange) {
		String changeType = dicCityChange.getChangeType();
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setPreUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreUpsCode(), "NAME"));
		dicCityChange.setLeve(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreChangeCode(), "LEVE"));
		if ("01".equals(changeType)) {
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','','','"
					+ dicCityChange.getPreUpsCode() + "','01','"+ batchId+ "','"+ changeId+ "');");
		}else if("02".equals(changeType.substring(0, 2))){
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','"
					+ dicCityChange.getPostChangeCode() + "','"
					+ dicCityChange.getPostChangeName() + "','"
					+ dicCityChange.getPostUpsCode() + "','02','"+ batchId+ "','"+ changeId+ "');");
			dicCityChange.setPostUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPostUpsCode(), "NAME"));
		}
		dicCityChangeDao.update(dicCityChange);
	}
	public void updateD(DicCityChange dicCityChange) {
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setPreUpsName(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreUpsCode(), "NAME"));
		dicCityChange.setLeve(DicUtil.getTextValueFromDic("DIC_CITY", "ID", dicCityChange.getPreChangeCode(), "LEVE"));
			dicCityChange.setChangeScript("bp_admstrat_division_changes('"
					+ dicCityChange.getPreChangeCode() + "','"
					+ dicCityChange.getPreChangeName() + "','','','"
					+ dicCityChange.getPreUpsCode() + "','03','"+ batchId+ "','"+ changeId+ "');");
		dicCityChangeDao.update(dicCityChange);
		//dicCityDataTransDao.batchInsert(dicCityChange.getDicCityDataTransList());
	}
	public void submit(DicCityChange dicCityChange) {
		dicCityChange.setChangeResult("1");
		dicCityChangeDao.update(dicCityChange);
	}

	public void check(DicCityChange dicCityChange) {
		String changeType = dicCityChange.getChangeType();
		dicCityChange.setChangeResult("2");
		dicCityChange.setChangePeople(GetBspInfo.getBspInfo().getUserName());
		dicCityChange.setChangeTime(DateUtil.getDay());
		dicCityChangeDao.update(dicCityChange);
		//执行存储过程变更行政区划
		if ("01".equals(changeType)) {
			changeType="01";
		}else if("02".equals(changeType.substring(0, 2))){
			changeType="02";
		}else if("03".equals(changeType)){
			changeType="03";
			ParameterSet transPset = new ParameterSet();
			transPset.put("CHANGE_ID", dicCityChange.getChangeId());
			DataSet ds = dicCityDataTransDao.query(transPset);
			for (int i = 0; i < ds.getCount(); i++) {
				DicCityDataTrans dicCityDataTrans = (DicCityDataTrans) ds.getRecord(i).toBean(DicCityDataTrans.class);
				dicCityDataTransDao.transDicCity(dicCityDataTrans.getPreChangeCode(),dicCityDataTrans.getPostChangeCode());
			}
		}
		dicCityChangeDao.changeDicCity(dicCityChange,changeType);
	}
	/**
	 * 删除 行政区划变更
	 * 
	 * @param changeId
	 */
	public void delete(String changeId) {
		dicCityChangeDao.delete(changeId);
	}
	/**
	 * 批次中上传附件
	 * 
	 * @param changeId
	 */
	public void batchUpdate(List list) {
		dicCityChangeDao.batchUpdate(list);
	}

	public DataSet queryTrans(ParameterSet pset) {
		return dicCityChangeDao.queryTrans(pset);
	}
}