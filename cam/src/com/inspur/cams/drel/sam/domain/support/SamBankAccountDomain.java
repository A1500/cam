package com.inspur.cams.drel.sam.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamBankAccountDao;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;

/**
 * @title:SamBankAccountDomain
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
public class SamBankAccountDomain implements ISamBankAccountDomain {
	@Reference
	private ISamBankAccountDao samBankAccountDao;
	
	@Trans
	public void insert(SamBankAccount samBankAccount) {
		samBankAccountDao.insert(samBankAccount);
	}

	public DataSet query(ParameterSet pset) {
		return samBankAccountDao.query(pset);
	}
	@Trans
	public void update(SamBankAccount samBankAccount) {
		samBankAccountDao.update(samBankAccount);
	}
	
	@Trans
	public void batchInsert(List<SamBankAccount> list) {
		samBankAccountDao.batchInsert(list);
	}

	@Trans
	public void batchUpdate(List<SamBankAccount> list) {
		samBankAccountDao.batchUpdate(list);
	}
	@Trans
	public void deleteAccount(String familyId) {
		samBankAccountDao.deleteAccount(familyId);
	}
}
