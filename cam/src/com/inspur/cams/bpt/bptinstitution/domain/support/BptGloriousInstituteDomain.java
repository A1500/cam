package com.inspur.cams.bpt.bptinstitution.domain.support;

import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.*; //import org.loushang.util.Page;
import org.loushang.sca.transaction.Trans; //import org.loushang.util.RowSelection;
import org.osoa.sca.annotations.*;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousDetailDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousInstituteDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousLegalDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptGloriousInstituteDomain;

/**
 * @title:BptGloriousInstituteDomain
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
 */
public class BptGloriousInstituteDomain implements IBptGloriousInstituteDomain {

	private IBptGloriousInstituteDao bptgloriousinstituteDao;

	private IBptGloriousLegalDao bptgloriouslegalDao;

	@Reference
	public void setBptGloriousInstituteDao(
			IBptGloriousInstituteDao bptgloriousinstituteDao) {
		this.bptgloriousinstituteDao = bptgloriousinstituteDao;
	}

	public void saveBptGloriousInstitute(List<BptGloriousInstitute> list) {
		this.bptgloriousinstituteDao.save(list);

	}

	@Reference
	public void setBptGloriousLegalDao(IBptGloriousLegalDao bptgloriouslegalDao) {
		this.bptgloriouslegalDao = bptgloriouslegalDao;
	}

	public void saveBptGloriousLegal(List<BptGloriousLegal> list) {
		if (list != null && !list.isEmpty()) {
			this.bptgloriouslegalDao.save(list);
		}
	}

	public DataSet queryBptGloriousLegal(ParameterSet pset) {
		return bptgloriouslegalDao.query(pset);
	}

	public void saveBptGloriousLegalList(
			BptGloriousInstitute bptgloriousinstitute,
			List<BptGloriousLegal> line) {
		List bptgloriousinstituteList = new ArrayList();
		bptgloriousinstituteList.add(bptgloriousinstitute);
		this.bptgloriousinstituteDao.save(bptgloriousinstituteList);
		if (line != null && !line.isEmpty()) {
			this.bptgloriouslegalDao.save(line);
		}
	}

	@Trans
	public void delete(List<String> list) {
		IBptGloriousDetailDao bptGloriousdetaildao = (IBptGloriousDetailDao) DaoFactory
				.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousDetailDao");
		
		String[] bptgloriousinstituteIds = list.toArray(new String[list.size()]);
		List<String> hlist = new ArrayList<String>();//获取bpthospitalDetailId 准备删除法人
		ParameterSet pset= new ParameterSet();
		
		for(int i = 0 ;i<bptgloriousinstituteIds.length;i++){
			pset.setParameter("GLORIOUS_ID", bptgloriousinstituteIds[i]);
			DataSet ds = bptGloriousdetaildao.query(pset);
			for(int j=0 ;j<ds.getCount();j++){
				hlist.add((String)ds.getRecord(j).get("id"));
			}
		}
		String[] bptgloriousDetailIds = hlist.toArray(new String[hlist.size()]);
			bptGloriousdetaildao.batchDeleteDetail(bptgloriousinstituteIds);
			bptgloriouslegalDao.batchDeleteByBptGloriousInstitute(bptgloriousDetailIds);
			bptgloriousinstituteDao.batchDeleteGlorious(bptgloriousinstituteIds);

	}

	

	public DataSet queryBptGloriousInstitute(ParameterSet pset) {
		return bptgloriousinstituteDao.query(pset);
	}
	// 删除光荣院年度信息
	public void gloriousDelete(String[] list) {
		IBptGloriousDetailDao BbptGloriousdetaildao = (IBptGloriousDetailDao) DaoFactory
				.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousDetailDao");
			BbptGloriousdetaildao.batchDeleteDetail(list);
			bptgloriouslegalDao.batchDeleteByBptGloriousInstitute(list);
	}
	public DataSet getMaxYear(ParameterSet pset){
		return bptgloriousinstituteDao.getMaxYear(pset);
	}
}