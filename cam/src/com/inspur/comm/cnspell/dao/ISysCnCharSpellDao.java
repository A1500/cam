package com.inspur.comm.cnspell.dao;

import java.util.List;

public interface ISysCnCharSpellDao {

	List getCnStrSpell(String cnStr, String type);
}