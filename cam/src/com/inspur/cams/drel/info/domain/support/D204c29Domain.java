package com.inspur.cams.drel.info.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.feedback.dao.IFeedBackDao;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204c29Dao;
import com.inspur.cams.drel.info.data.D204c29;
import com.inspur.cams.drel.info.domain.ID204c29Domain;
import com.inspur.cams.drel.temp.dao.ID204c29TempDao;

/**
 * 理财domain
 * @author 
 * @date 2014-06-09
 */
public class D204c29Domain implements ID204c29Domain {

	@Reference
	private ID204c29Dao d204c29Dao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204c29TempDao d204c29TempDao;
	/**
	 * 查询 理财
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c29Dao.query(pset);
	}

	/**
	 * 获取 理财
	 * @param pset
	 * @return
	 */
	public D204c29 get(String d204c29Id) {
		
		return d204c29Dao.get(d204c29Id);
	}

	/**
	 * 增加 理财
	 * @param d204c29
	 */
	public void insert(D204c29 d204c29) {
		d204c29.setD204c29Id(IdHelp.getUUID32());
		d204c29.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204c29.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204c29.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204c29.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204c29.setInputTime(DateUtil.getTime());
		d204c29Dao.insert(d204c29);
	}
	
	/**
	 * 修改 理财
	 * @param d204c29
	 */
	public void update(D204c29 d204c29) {
		d204c29Dao.update(d204c29);
	}
	
	/**
	 * 删除 理财
	 * @param d204c29Id
	 */
	public void delete(String d204c29Id) {
		d204c29Dao.delete(d204c29Id);
	}
	public void insertFromTemp(Record[] records) {
		// TODO Auto-generated method stub
		List<D204c29> list = new ArrayList<D204c29>();
		String[] mainIds = new String[records.length];
		for(int i=0;i<records.length;i++){
			Record r =records[i];
			D204c29 d = new D204c29();
			mainIds[i]=(String)r.get("D204C29_ID");
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILY_ID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204c290001((String)r.get("D204C290001"));
			d.setD204c290002("".equals(r.get("D204C290002"))?null:new BigDecimal(r.get("D204C290002")+""));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			
			d.setD204c29Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			d.setSourceType("1");
			
			list.add(d);
		}
		d204c29Dao.batchInsert(list);
		d204c29TempDao.batchUpdateStatus(mainIds);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204c29> list = new ArrayList<D204c29>();
		String[] mainIds = new String[ds.getCount()];
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("D204C29_ID");
			D204c29 d = new D204c29();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setD204c290001((String)r.get("D204C290001"));
			d.setD204c290002(new BigDecimal(r.get("D204C290002")+""));
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204c29Id(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		d204c29Dao.batchInsert(list);
		d204c29TempDao.batchUpdateStatus(mainIds);
	}
}