package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamBankAccount;

/**
 * @title:ISamBankAccountDao
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
 public interface ISamBankAccountDao extends BaseCURD<SamBankAccount>{
	public void save(List<SamBankAccount> list);

	public void deleteAccount(String familyId);
}

