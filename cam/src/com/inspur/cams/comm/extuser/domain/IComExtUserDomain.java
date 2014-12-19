package com.inspur.cams.comm.extuser.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 外部单位用户domain接口
 * @author shgtch
 * @date 2011-6-28
 */
public interface IComExtUserDomain {

	/**
	 * 获取外部单位用户信息
	 * @param userId
	 * @return
	 */
	
	public ComExtUser getComExtUser(String userId);
	
	/**
	 * 增加外部单位用户信息
	 * @param comExtUser
	 */
	@Trans
	public void insertComExtUser(ComExtUser comExtUser);
	
	@Trans
    public  void insertUser(ComExtUser comExtUser);
	
	@Trans
	public  void saveUser(List list);
	
	@Trans
	public  void deleteUser(String userId);
	
	@Trans
	public  void deleteSelected(String[] delIds);

	/**
	 * 更新外部单位用户信息
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtUser(ComExtUser comExtUser);

	/**
	 * 逻辑删除外部单位用户信息
	 * @param userId
	 */
	@Trans
	public void deleteComExtUser(String userId);

	/**
	 * 通用单位内码逻辑删除外部单位用户
	 * @param organId
	 */
	@Trans
	public void deleteComExtUserByOrganId(String organId);

	/**
	 * 查询外部单位用户信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtUser(ParameterSet ps);

	/**
	 * 批量删除外部单位用户
	 * @param delIds
	 */
	@Trans
	public void batchDelete(String[] delIds);


	@Trans
	public void delete(String userId);
	@Trans
	public void updatePassWord(String userId,String passWord);
	/**
	 * 批量解冻用户（社会组织江西年检用）
	 * @param comExtUsers
	 */
	@Trans
	public void batchUpdateComExtUser(List<ComExtUser> comExtUsers);

	/**
	 * 更新社会组织外部用户信息
	 * 2013年10月21日
	 */
	public void updateSomExtuserBychangge(String changgebefore,	String changgeafter);

	//通过变更事项更改外部组织菜单权限的用户名
    public void updateSorgcode(String sorgcode,String cnName );

    public void createextuserbycl(SomOrgan organBean);
}
