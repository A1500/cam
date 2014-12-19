package com.inspur.cams.drel.sam.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamBankAccount;

/**
 * @title:ISamBankAccountDomain
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
 public interface ISamBankAccountDomain {
	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加
	 * @param SamBankAccount
	 */
	@Trans
	public void insert(SamBankAccount samBankAccount);
	
	/**
	 * 更新
	 * @param SamBankAccount
	 */
	@Trans
	public void update(SamBankAccount samBankAccount);

	@Trans
	public void batchInsert(List<SamBankAccount> list);
	
	@Trans
	public void batchUpdate(List<SamBankAccount> list);
	@Trans
	public void deleteAccount(  String familyId);
}
