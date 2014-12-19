package com.inspur.cams.comm.diccityChange.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChange;
import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeDomain;
import com.inspur.cams.comm.diccityChange.domain.IDicCityDataTransDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 行政区划变更cmd
 * @author 
 * @date 2013-12-23
 */
public class DicCityChangeCmd extends BaseAjaxCommand {

	private IDicCityChangeDomain dicCityChangeDomain = ScaComponentFactory
			.getService(IDicCityChangeDomain.class, "dicCityChangeDomain/dicCityChangeDomain");
	
	private IDicCityDataTransDomain dicCityDataTransDomain = ScaComponentFactory
			.getService(IDicCityDataTransDomain.class, "dicCityDataTransDomain/dicCityDataTransDomain");
	
	DicCityDao cityDao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		dicCityChangeDomain.insert(dicCityChange);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		dicCityChangeDomain.update(dicCityChange);
	}
	// 提交
	public void submit() {
		Record record = (Record) getParameter("record");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		dicCityChangeDomain.submit(dicCityChange);
	}
	// 审批
	public void check() {
		Record record = (Record) getParameter("record");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		dicCityChangeDomain.check(dicCityChange);
	}
	// 删除
	public void delete() {
		String changeId = (String) getParameter("changeId");
		dicCityChangeDomain.delete(changeId);
	}
	public void deleteByTrans() {
		String changeId = (String) getParameter("changeId");
		dicCityDataTransDomain.deleteByTrans(changeId);
		dicCityChangeDomain.delete(changeId);
	}
	// 删除
	public void deleteAll() {
		String changeId = (String) getParameter("changeId");
		dicCityChangeDomain.delete(changeId);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CHANGE_ID@", changeId);
		DataSet ds = dicCityDataTransDomain.query(pset);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				dicCityDataTransDomain.delete((String)ds.getRecord(i).get("changeId"));
			}
		}
	}
	//校验通过后保存更改记录
	public void updateAll(){
		Record[] records = (Record[]) getParameter("records");
		for(int i=0;i<records.length;i++){
			DicCityChange dicCityChange = (DicCityChange) records[i].toBean(DicCityChange.class);
			dicCityChangeDomain.update(dicCityChange);
		}
	}
	
	//查询是否重复
	public void query() {
		String code = (String) getParameter("code");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ID@=", code);
		DataSet ds = cityDao.query(pset);
		if(ds.getCount()>0){
			this.setReturn("tips","区划代码重复!");
		}
	}
	
	
	//查询是否重复
	public void isRepeatOneBatch() {
		String code = (String) getParameter("code");
		String batchId = (String) getParameter("batchId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("POST_CHANGE_CODE@=", code);
		pset.setParameter("CHANGE_TYPE@rLIKE","02");
		pset.setParameter("BATCH_ID@=", batchId);
		DataSet ds = dicCityChangeDomain.query(pset);
		if(ds.getCount()>1){
			this.setReturn("warn","该批次中【变更后区划代码】已被使用");
		}
	}
	//查询序号是否重复
	public void isRepeat() {
		String batchId = (String) getParameter("batchId");
		String serialNum = (String) getParameter("serialNum");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_ID@=",batchId);
		pset.setParameter("SERIAL_NUM@=",serialNum);
		DataSet ds = dicCityChangeDomain.query(pset);
		if(ds.getCount()>0){
			this.setReturn("flag","同一批次的序号不能重复!");
		}
	}
	
	//查询本批次是否已录该区划
	public void ifRepeated() {
		String batchId = (String) getParameter("batchId");
		String preChangeCode = (String) getParameter("preChangeCode");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_ID@=",batchId);
		pset.setParameter("PRE_CHANGE_CODE@=",preChangeCode);
		DataSet ds = dicCityChangeDomain.query(pset);
		if(ds.getCount()>0){
			this.setReturn("ifRepeatTips","该批次已经录入改区划，不可重复录入!");
		}
	}
	
	//查询本批次是否已录该区划
	public void getNumber() {
		String batchId = (String) getParameter("batchId");
		String maxNum = dicCityChangeDomain.getNumber(batchId);
		this.setReturn("maxNum",maxNum);
		
	}
	// 增加
	public void insertD() {
		Record record = (Record) getParameter("record");
		Record[] dicCityDetailRecords = (Record[]) getParameter("dicCityDetailRecords");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setChangeId(changeId);
		dicCityChange.setChangeResult("0");
		dicCityChange.setState(Record.STATE_NEW);
		
		List<DicCityDataTrans> dicCityDataTransList = new ArrayList<DicCityDataTrans>();
		if (dicCityDetailRecords != null && dicCityDetailRecords.length > 0) {
			for (int i = 0; i < dicCityDetailRecords.length; i++) {
				DicCityDataTrans dicCityDataTrans = (DicCityDataTrans) dicCityDetailRecords[i].toBean(DicCityDataTrans.class);
				dicCityDataTrans.setTransId(IdHelp.getUUID32());
				dicCityDataTrans.setChangeId(changeId);
				if("1".equals(dicCityDataTrans.getTransType())){
					dicCityDataTrans.setTransScript("bp_admstrat_division_changes('"
									+ dicCityDataTrans.getPreChangeCode()+ "','"
									+ dicCityDataTrans.getPreChangeName()+ "','"
									+ dicCityDataTrans.getPostChangeCode()+ "','"
									+ dicCityDataTrans.getPostChangeName()
									+ "','','02','"+ batchId+ "','"+ changeId+ "');");
				}else if("0".equals(dicCityDataTrans.getTransType())){
					dicCityDataTrans.setTransScript("bp_area_data_change('"
									+ dicCityDataTrans.getPreChangeCode()+ "','','"
									+ dicCityDataTrans.getPostChangeCode()+ "','"
									+ dicCityDataTrans.getPostChangeName()
									+ "','','04','"+ batchId+ "','"+ changeId + "');");
					dicCityDataTrans.setDeleteScript("bp_admstrat_division_changes('"
									+ dicCityDataTrans.getPreChangeCode()+ "','','"
									+ dicCityDataTrans.getPostChangeCode()+ "','"
									+ dicCityDataTrans.getPostChangeName()
									+ "','','03','"+ batchId+ "','"+ changeId + "');");
				}
				
				dicCityDataTrans.setState(Record.STATE_NEW);
				dicCityDataTransList.add(dicCityDataTrans);
			}
		}
		dicCityChange.setDicCityDataTransList(dicCityDataTransList);
		dicCityChangeDomain.insertD(dicCityChange);
	}
	
	// 修改
	public void updateD() {
		Record record = (Record) getParameter("record");
		Record[] dicCityDetailRecords = (Record[]) getParameter("dicCityDetailRecords");
		DicCityChange dicCityChange = (DicCityChange) record.toBean(DicCityChange.class);
		String changeId=dicCityChange.getChangeId();
		String batchId=dicCityChange.getBatchId();
		dicCityChange.setState(Record.STATE_MODIFIED);
		//dicCityDataTransDomain.deleteByTrans(changeId);
		//List<DicCityDataTrans> dicCityDataTransList = new ArrayList<DicCityDataTrans>();
		if (dicCityDetailRecords != null && dicCityDetailRecords.length > 0) {
			for (int i = 0; i < dicCityDetailRecords.length; i++) {
				DicCityDataTrans dicCityDataTrans = (DicCityDataTrans) dicCityDetailRecords[i].toBean(DicCityDataTrans.class);
				dicCityDataTransDomain.transSave(dicCityDataTrans,changeId,batchId);
			}
		}
		//dicCityChange.setDicCityDataTransList(dicCityDataTransList);
		dicCityChangeDomain.updateD(dicCityChange);
	}
	
	/**
	 * 查询nameById
	 * @return
	 */
	public void getNameById() {
		ParameterSet ps = getParameterSet();
		String id = (String) ps.getParameter("id");
		setReturn("cityName",cityDao.getOrganNameById(id));
	}
	
	public void queryTrans() {
		ParameterSet ps = getParameterSet();
		DataSet ds = dicCityChangeDomain.queryTrans(ps);
		if(ds.getCount()>0){
			this.setReturn("transTips","【区划撤销】中有未指明数据迁移的数据，请检查后重新上报!");
		}
	}
}