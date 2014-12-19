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
import com.inspur.cams.drel.info.dao.ID204c21DieDao;
import com.inspur.cams.drel.info.data.D204c21Die;
import com.inspur.cams.drel.info.domain.ID204c21DieDomain;
import com.inspur.cams.drel.temp.dao.ID204c21DieTempDao;

/**
 * 车辆domain
 * @author 
 * @date 2014-06-09
 */
public class D204c21DieDomain implements ID204c21DieDomain {

	@Reference
	private ID204c21DieDao D204c21DieDao;
	@Reference
	private IFeedBackDao feedBackDao;
	@Reference
	private ID204c21DieTempDao D204c21DieTempDao;
	/**
	 * 查询 车辆
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return D204c21DieDao.query(pset);
	}

	/**
	 * 获取 车辆
	 * @param pset
	 * @return
	 */
	public D204c21Die get(String D204c21DieId) {
		return D204c21DieDao.get(D204c21DieId);
	}

	/**
	 * 增加 车辆
	 * @param D204c21Die
	 */
	public void insert(D204c21Die D204c21Die) {
		D204c21Die.setD204c21DieId(IdHelp.getUUID32());
		D204c21Die.setInputOrgan(BspExtUtil.getBelongOrganName());
		D204c21Die.setInputOrganId(BspExtUtil.getBelongOrganId());
		D204c21Die.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		D204c21Die.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		D204c21Die.setInputTime(DateUtil.getTime());
		D204c21DieDao.insert(D204c21Die);
	}
	
	/**
	 * 修改 车辆
	 * @param D204c21Die
	 */
	public void update(D204c21Die D204c21Die) {
		D204c21DieDao.update(D204c21Die);
	}
	
	/**
	 * 删除 车辆
	 * @param D204c21DieId
	 */
	public void delete(String D204c21DieId) {
		D204c21DieDao.delete(D204c21DieId);
	}
	public void insertFromTemp(Record[] records){
		List<D204c21Die> list = new ArrayList<D204c21Die>();
		String[] mainIds = new String[records.length];
		for(int i=0;i<records.length;i++){
			Record r =records[i];
			D204c21Die d = new D204c21Die();
			mainIds[i]=(String)r.get("D204c21Die_ID");
			//d.setCommissionId((String)r.get("COMMID"));
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILY_ID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
			d.setAdress((String)r.get("ADRESS"));
			/*d.setD204c21Die0002((String)r.get("D204c21Die0002"));
			d.setD204c21Die0003("".equals(r.get("D204c21Die0003"))?null:new BigDecimal(r.get("D204c21Die0003")+""));
			d.setD204c21Die0004((String)r.get("D204c21Die0004"));
			d.setD204c21Die0005((String)r.get("D204c21Die0005"));
			d.setD204c21Die0006("".equals(r.get("D204c21Die0006"))?null:new BigDecimal(r.get("D204c21Die0006")+""));
			d.setD204c21Die0007((String)r.get("D204c21Die0007"));
			d.setD204c21Die0008((String)r.get("D204c21Die0008"));
			d.setD204c21Die0009((String)r.get("D204c21Die0009"));
			d.setD204c21Die0010("".equals(r.get("D204c21Die0010"))?null:new BigDecimal(r.get("D204c21Die0010")+""));
			d.setD204c21Die0011((String)r.get("D204c21Die0011"));
			d.setD204c21Die0012((String)r.get("D204c21Die0012"));
			d.setD204c21Die0013((String)r.get("D204c21Die0013"));
			d.setD204c21Die0014("".equals(r.get("D204c21Die0014"))?null:new BigDecimal(r.get("D204c21Die0014")+""));*/
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204c21DieId(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		D204c21DieDao.batchInsert(list);
		D204c21DieTempDao.batchUpdateStatus(mainIds);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
		pset.setParameter("ifNopage", "1");
		DataSet ds = feedBackDao.queryCompareResultInfo(pset);
		List<D204c21Die> list = new ArrayList<D204c21Die>();
		String[] mainIds = new String[ds.getCount()];
		for(int i=0;i<ds.getCount();i++){
			Record r =ds.getRecord(i);
			mainIds[i]=(String)r.get("D204c21Die_ID");
			D204c21Die d = new D204c21Die();
			d.setCommissionId((String)r.get("COMMISSIONID"));
			d.setInfoQueryId((String)r.get("INFOQUERYID"));
			d.setFamilyId((String)r.get("FAMILYID"));
			d.setPeopleId((String)r.get("PEOPLEID"));
		/*	d.setD204c21Die0001((String)r.get("D204c21Die0001"));
			d.setD204c21Die0002((String)r.get("D204c21Die0002"));
			d.setD204c21Die0003(new BigDecimal(r.get("D204c21Die0003")+""));
			d.setD204c21Die0004((String)r.get("D204c21Die0004"));
			d.setD204c21Die0005((String)r.get("D204c21Die0005"));
			d.setD204c21Die0006(new BigDecimal(r.get("D204c21Die0006")+""));
			d.setD204c21Die0007((String)r.get("D204c21Die0007"));
			d.setD204c21Die0008((String)r.get("D204c21Die0008"));
			d.setD204c21Die0009((String)r.get("D204c21Die0009"));
			d.setD204c21Die0010(new BigDecimal(r.get("D204c21Die0010")+""));
			d.setD204c21Die0011((String)r.get("D204c21Die0011"));
			d.setD204c21Die0012((String)r.get("D204c21Die0012"));
			d.setD204c21Die0013((String)r.get("D204c21Die0013"));
			d.setD204c21Die0014(new BigDecimal(r.get("D204c21Die0014")+""));*/
			d.setInputBatchCode((String) r.get("INPUT_BATCH_CODE"));
			d.setSourceType("1");
			
			d.setD204c21DieId(IdHelp.getUUID32());
			d.setInputOrgan(BspExtUtil.getBelongOrganName());
			d.setInputOrganId(BspExtUtil.getBelongOrganId());
			d.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
			d.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
			d.setInputTime(DateUtil.getTime());
			
			list.add(d);
		}
		D204c21DieDao.batchInsert(list);
		D204c21DieTempDao.batchUpdateStatus(mainIds);
	}
}