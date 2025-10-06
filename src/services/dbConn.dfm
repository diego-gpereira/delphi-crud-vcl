object dtmConn: TdtmConn
  Height = 480
  Width = 640
  object FDConn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Desenvolvimento\Treinamentos_Diego\Delphi\API Swagge' +
        'r + DBA\DBA\MeuBANCO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 272
    Top = 112
  end
  object qryListagem: TFDQuery
    Active = True
    DetailFields = 'CPF;DATA_NASCIMENTO;FOTO;NOME;RG;SEQUENCIA;SEXO'
    Connection = FDConn
    SQL.Strings = (
      'select '
      ' p.sequencia,'
      ' p.nome,'
      ' p.rg,'
      ' p.cpf,'
      ' p.sexo,'
      ' p.data_nascimento,'
      ' p.foto'
      'from pessoas p'
      'order by p.sequencia')
    Left = 48
    Top = 216
    object qryListagemSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryListagemNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryListagemRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 9
    end
    object qryListagemCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryListagemSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object qryListagemDATA_NASCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_NASCIMENTO'
      Origin = 'DATA_NASCIMENTO'
    end
    object qryListagemFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object qryCadastro: TFDQuery
    Active = True
    DetailFields = 'CPF;DATA_NASCIMENTO;FOTO;NOME;RG;SEQUENCIA;SEXO'
    Connection = FDConn
    SQL.Strings = (
      'SELECT * FROM PESSOAS')
    Left = 192
    Top = 216
    object qryCadastroSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryCadastroRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 9
    end
    object qryCadastroCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryCadastroSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object qryCadastroDATA_NASCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_NASCIMENTO'
      Origin = 'DATA_NASCIMENTO'
    end
    object qryCadastroFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object dsCadastro: TDataSource
    DataSet = qryCadastro
    Left = 192
    Top = 288
  end
  object dsListagem: TDataSource
    DataSet = qryListagem
    Left = 48
    Top = 280
  end
  object qryAlteracao: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT * FROM PESSOAS'
      'WHERE SEQUENCIA = :SEQUENCIA'
      ''
      '')
    Left = 328
    Top = 224
    ParamData = <
      item
        Name = 'SEQUENCIA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryAlteracaoSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAlteracaoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryAlteracaoRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 9
    end
    object qryAlteracaoCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryAlteracaoSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object qryAlteracaoDATA_NASCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_NASCIMENTO'
      Origin = 'DATA_NASCIMENTO'
    end
    object qryAlteracaoFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object dsAlteracao: TDataSource
    DataSet = qryAlteracao
    Left = 328
    Top = 296
  end
end
