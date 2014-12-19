package com.inspur.cams.comm.diccityChange.domain.support;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeBatchAttachDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchAttachDomain;

/**
 * 区划变更上传附件表domain
 * @author 
 * @date 2014-01-13
 */
public class DicCityChangeBatchAttachDomain implements IDicCityChangeBatchAttachDomain {

	@Reference
	private IDicCityChangeBatchAttachDao dicCityChangeBatchAttachDao;

	/**
	 * 查询 区划变更上传附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCityChangeBatchAttachDao.query(pset);
	}

	/**
	 * 获取 区划变更上传附件表
	 * @param pset
	 * @return
	 */
	public DicCityChangeBatchAttach get() {
		return  null;//dicCityChangeBatchAttachDao.get();
	}

	/**
	 * 增加 区划变更上传附件表
	 * @param dicCityChangeBatchAttach
	 */
	public void insert(DicCityChangeBatchAttach dicCityChangeBatchAttach) {
		dicCityChangeBatchAttachDao.insert(dicCityChangeBatchAttach);
	}
	
	/**
	 * 修改 区划变更上传附件表
	 * @param dicCityChangeBatchAttach
	 */
	public void update(DicCityChangeBatchAttach dicCityChangeBatchAttach) {
		dicCityChangeBatchAttachDao.update(dicCityChangeBatchAttach);
	}
	
	/**
	 * 删除 区划变更上传附件表
	 * @param 
	 */
	public void delete(String delId) {
		dicCityChangeBatchAttachDao.delete(delId);
	}
	
	/**
	 * 批量新增
	 * @param 
	 */
	public void saveAll(List list) {
		dicCityChangeBatchAttachDao.batchInsert(list);
	}
	
}