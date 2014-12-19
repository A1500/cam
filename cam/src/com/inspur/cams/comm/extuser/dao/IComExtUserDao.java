package com.inspur.cams.comm.extuser.dao;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 外部单位用户dao接口
 * @author shgtch
 * @date 2011-6-29
 */
public interface IComExtUserDao {

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
	public void insertComExtUser(ComExtUser comExtUser);
	
  public  void deleteSelected(String[] delIds);

  public  void saveUser(List list);


	/**
	 * 更新外部单位用户信息
	 * @param comExtUser
	 */
	public void updateComExtUser(ComExtUser comExtUser);

	/**
	 * 逻辑删除外部单位用户信息
	 * @param userId
	 */
	public void deleteComExtUser(String userId);

	/**
	 * 根据单位内码逻辑删除用户
	 * @param organId
	 */
	public void deleteComExtUserByOrganId(String organId);

	/**
	 * 查询外部单位用户信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtUser(ParameterSet ps);

	public void delete(String userId);
	/**
	 * 龙头企业修改密码
	 * @param userId
	 * @param passWord
	 */
	public void updatePassWord(String userId,String passWord);

    public void batchUpdateComExtUser(List<ComExtUser> comExtUsers);


    //通过变更事项更改外部组织用户名

    public void updateExtuserbychangge(String changgebefore,String changgeafter);
  //通过变更事项更改外部组织菜单权限的用户名
    public void updatesomExtuserMenubychangge(String changgebefore,String changgeafter);
  //通过变更事项更改外部组织菜单权限的用户名
    public void updateSorgcode(String sorgcode,String cnName );

    //判断是否已经创建外单位用户
    public Integer ifcreateextuser(String user_name);
}
