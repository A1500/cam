package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisResourceFormatDao;
import com.inspur.cams.fis.base.data.FisResourceFormat;
import com.inspur.cams.fis.base.domain.IFisResourceFormatDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisResourceFormatDomain  
 * @Description: TODO 殡葬业务资源规格表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
 public class FisResourceFormatDomain implements IFisResourceFormatDomain{
	
	@Reference
	private IFisResourceFormatDao fisResourceFormatDao;
	 
	public DataSet query(ParameterSet pset){
		return fisResourceFormatDao.query(pset);
	}
	
	public void insert(FisResourceFormat fisResourceFormat){
		fisResourceFormatDao.insert(fisResourceFormat);
	}
	
	public void batchInsert(List<FisResourceFormat> list){
		fisResourceFormatDao.batchInsert(list);
	}
	
	public void update(FisResourceFormat fisResourceFormat){
		fisResourceFormatDao.update(fisResourceFormat);
	}
	
	public void batchUpdate(List<FisResourceFormat> list){
		fisResourceFormatDao.batchUpdate(list);
	}
	public void delete(String[] delIds){
		fisResourceFormatDao.batchDelete(delIds);
	}
	
	public void save(List<FisResourceFormat> list){
		fisResourceFormatDao.save(list);
	}
}